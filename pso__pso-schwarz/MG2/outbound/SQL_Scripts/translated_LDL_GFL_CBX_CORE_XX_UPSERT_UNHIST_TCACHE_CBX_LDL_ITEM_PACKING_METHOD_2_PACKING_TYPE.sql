
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, lang_cd, packing_type_name,
 packing_type_descr, packing_type_cd)
(SELECT DISTINCT 'CBX' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'CBX' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'DE' AS lang_cd,
    TRIM(SUBSTR(ldl_name, 0, 14)) || '-' || SUBSTR(TRIM(ldl_code), 7, 7) AS packing_type_name,
    TRIM(SUBSTR(ldl_name, 0, 14)) || '-' || SUBSTR(TRIM(ldl_code), 7, 7) AS packing_type_descr,
  ldl_code AS packing_type_cd
 FROM ${temp_db}.${t_src_input_table} AS src
 WHERE ldl_name LIKE 'Packing Method%');