
-- framework and technical columns


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'SLS_UNK',
  'EKS' AS source_system,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  ke.prod_variant_sid,
  UPPER(src.ctrcode || '|' || CAST(src.itemno_wawi AS STRING)) AS nk
 FROM (SELECT CASE
     WHEN itm.bitflag = 0
     THEN a.itemno
     ELSE a.prod_num
     END AS prod_variant_nat_key_nr,
     CASE
     WHEN itm.bitflag = 0
     THEN 'EKS_SLS'
     ELSE 'EKS_SLS_UNK'
     END AS prod_variant_key_type_cd,
    a.ctrcode,
    a.itemno_wawi
   FROM ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item AS a
    INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item AS itm ON a.itemno = itm.itemno
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.ctrcode, a.itemno_wawi ORDER BY CASE
          WHEN itm.bitflag = 0
          THEN 'EKS_SLS'
          ELSE 'EKS_SLS_UNK'
          END IS NULL DESC, CASE
          WHEN itm.bitflag = 0
          THEN 'EKS_SLS'
          ELSE 'EKS_SLS_UNK'
          END DESC, itm.seqid IS NULL DESC, itm.seqid DESC, itm.extraction_tmsp IS NULL DESC, itm.extraction_tmsp DESC)
      ) = 1) AS src
  INNER JOIN ldl_data_production_meta.t_product_variant_key AS ke ON src.prod_variant_key_type_cd = ke.prod_variant_key_type_cd
      AND CAST(src.prod_variant_nat_key_nr AS STRING) = ke.prod_variant_nat_key_nr AND CURRENT_TIMESTAMP() BETWEEN ke.dwh_valid_from_tmsp
    AND ke.dwh_valid_to_tmsp);