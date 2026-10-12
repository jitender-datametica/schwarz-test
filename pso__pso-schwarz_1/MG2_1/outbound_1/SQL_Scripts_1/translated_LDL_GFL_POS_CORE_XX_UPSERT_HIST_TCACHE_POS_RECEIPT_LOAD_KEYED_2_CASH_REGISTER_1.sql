
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, cash_register_nr, pos_terminal_id,
 orig_store_nr, context_country, real_estate_sid, cash_register_sid)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${V_SRC_INPUT_TABLE}' AS filename,
  CAST(pos_terminal_id AS STRING) AS cash_register_nr,
  pos_terminal_id,
  orig_store_nr,
  context_country,
  real_estate_sid,
  cash_register_sid
 FROM ${temp_db}.${v_src_input_table} AS src
 GROUP BY context_country,
  orig_store_nr,
  cash_register_sid,
  pos_terminal_id,
  real_estate_sid);