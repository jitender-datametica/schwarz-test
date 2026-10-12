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

 SELECT
        prod_variant_sid,
        'SLS_GTIN',        
        UPPER(itemno_wawi || '|' || ean), 
        'EKS' AS SOURCE_SYSTEM,        
        extraction_tmsp AS dwh_mapping_tmsp,
        extraction_tmsp AS extraction_dt,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_WH' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id
FROM
(
  SELECT DISTINCT
        prod_variant_sid,ean.itemno,eksw.itemno_wawi,ean.ean, ean.extraction_tmsp
   FROM etl.t_wawi_precore_eks_hierarchy AS eksh
  INNER JOIN etl.t_wawi_precore_t029_wawi_item_ean AS ean ON  eksh.itemno_ea = ean.itemno
  INNER JOIN etl.t_wawi_precore_eks_item_wawi_item AS eksw ON  eksh.itemno_ba = eksw.prod_num
  INNER JOIN meta.t_product_variant_key ke 
     ON prod_variant_key_type_cd='EKS_SLS' 
    AND CAST(eksh.itemno_ea AS VARCHAR)=ke.prod_variant_nat_key_nr 
    AND CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
 )
;
