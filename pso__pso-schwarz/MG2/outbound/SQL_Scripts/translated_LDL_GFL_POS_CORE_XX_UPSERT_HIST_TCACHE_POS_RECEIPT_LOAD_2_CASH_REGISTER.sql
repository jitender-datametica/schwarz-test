
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, cash_register_key_type_cd,
 cash_register_nr, real_estate_key_type_cd, pos_terminal_id, orig_store_nr, context_country)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'REG' AS cash_register_key_type_cd,
  CAST(pos_terminal_id AS STRING) AS cash_register_nr,
  'RE' AS real_estate_key_type_cd,
  pos_terminal_id,
  orig_store_nr,
  context_country
 FROM ${temp_db}.${t_src_input_table} AS src
 GROUP BY context_country,
  orig_store_nr,
  pos_terminal_id);