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
        'SLS_UNK',        
        UPPER(ctrcode || '|' || itemno_wawi) as nk, 
        'EKS' AS SOURCE_SYSTEM,        
        CURRENT_TIMESTAMP AS dwh_mapping_tmsp,
        CURRENT_TIMESTAMP  AS extraction_dt,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_WH' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id
FROM
(
SELECT
    CASE WHEN itm.bitflag = 0 THEN a.itemno
               ELSE a.prod_num
    END AS prod_variant_nat_key_nr
  , CASE WHEN itm.bitflag = 0 THEN 'EKS_SLS'
               ELSE 'EKS_SLS_UNK'
    END AS prod_variant_key_type_cd
  , a.ctrcode
  , a.itemno_wawi
FROM ETL.t_wawi_precore_eks_item_wawi_item_1 AS a
INNER JOIN ETL.t_wawi_precore_t026_wawi_item_1 AS itm
ON  a.itemno = itm.itemno
QUALIFY Row_Number() OVER (PARTITION BY a.ctrcode, a.itemno_wawi
                           ORDER BY prod_variant_key_type_cd DESC
                                  , itm.seqid DESC
                                  , itm.extraction_tmsp DESC) = 1
) AS src
INNER JOIN meta.t_product_variant_key_1 ke 
   ON ke.prod_variant_key_type_cd=src.prod_variant_key_type_cd 
  AND CAST(src.prod_variant_nat_key_nr AS VARCHAR)=ke.prod_variant_nat_key_nr 
  AND CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
;
