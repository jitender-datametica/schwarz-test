
-- FRAMEWORK AND TECHNICAL COLUMNS


-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, prod_nr, dwh_mapping_tmsp, prod_key_type_cd, int_org_key_type_cd,
 prod_ident_nr, prod_ident_type_cd, ctrcode)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(prod_num AS STRING) AS prod_nr,
  CAST(CURRENT_DATE AS TIMESTAMP) AS dwh_mapping_tmsp,
  'EKS' AS prod_key_type_cd,
  'COUNTRY' AS int_org_key_type_cd,
  CAST(itemno_wawi AS STRING) AS prod_ident_nr,
  'WAWI' AS prod_ident_type_cd,
   CASE
   WHEN ctrcode = 'CS'
   THEN 'ES'
   ELSE ctrcode
   END AS ctrcode
 FROM ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item AS pr);