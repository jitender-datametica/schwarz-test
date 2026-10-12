INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 dwh_ending_tmsp, some_sum, id2, id1, status_cd)
(SELECT 'TEST_1' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'TEST_1' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(val_from AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  CAST(val_to AS TIMESTAMP) AS dwh_ending_tmsp,
  some_sum,
  id2,
  id1,
  status_cd
 FROM ${temp_db}.t_${src_input_table} AS src);