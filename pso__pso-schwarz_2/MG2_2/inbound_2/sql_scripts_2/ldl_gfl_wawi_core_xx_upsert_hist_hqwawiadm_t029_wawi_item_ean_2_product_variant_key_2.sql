INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        prod_variant_sid,
        prod_variant_key_type_cd,
        prod_variant_nat_key_nr,
        -- framework and technical columns
        source_system,
        dwh_mapping_tmsp,
        extraction_dt,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
with t029 AS
(
  SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t029_wawi_item_ean_2 AS src
  INNER JOIN ( SELECT wawi_instanz_kzl
                    , Rank() OVER (ORDER BY CASE WHEN wawi_instanz_kzl = 'DE' THEN 1
                                                 WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN wawi_instanz_kzl = 'GR' THEN 3
                                                 WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                                             END, wawi_instanz_kzl) AS eks_rank
                FROM ( SELECT DISTINCT LEFT(wawi_instanz_kzl,2) AS  wawi_instanz_kzl
                       FROM LDL_WAWI_PRODUCTION.hqwawiadm.t029_wawi_item_ean_2
                       WHERE delete_fg IS NULL
                      ) AS a
            ) AS csrc
        ON  LEFT(src.wawi_instanz_kzl,2) = csrc.wawi_instanz_kzl
  WHERE src.delete_fg IS NULL 
  QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.itemno, src.ean_2)
  AND Row_Number() OVER (PARTITION BY src.ean_2, LEFT(src.wawi_instanz_kzl,2) ORDER BY src.seqid DESC) = 1

)
SELECT
        prod_variant_sid,
        'SLS_GTIN',        
        UPPER(itemno_wawi || '|' || ean_2), 
        'EKS' AS SOURCE_SYSTEM,        
        extraction_tmsp AS dwh_mapping_tmsp,
        extraction_tmsp AS extraction_dt,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_hqwawiadm.t029_wawi_item_ean_2' AS filename,
        'WAWI_WH' AS dwh_node_cd,
        '733875' as dwh_load_id
FROM
(
  SELECT DISTINCT
        prod_variant_sid,ean.itemno,eksw.itemno_wawi,ean.ean_2, ean.extraction_tmsp 
   FROM etl.t_tcache_eks_hierarchy_2 AS eksh
  INNER JOIN t029 AS ean_2 ON  eksh.itemno_ea = ean.itemno
  INNER JOIN etl.t_tcache_eks_item_wawi_item_2 AS eksw ON  eksh.itemno_ba = eksw.prod_num 
  INNER JOIN meta.t_product_variant_key_2 ke 
     ON prod_variant_key_type_cd='EKS_SLS' 
    AND CAST(eksh.itemno_ea AS VARCHAR)=ke.prod_variant_nat_key_nr 
    AND CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp    
 )
;
