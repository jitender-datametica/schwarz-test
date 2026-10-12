
INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, source_system,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, lang_cd, planned_val_role_cd,
 planned_val_type_key_natural_key, planned_val_type_id, planning_process_cd, planned_val_type_key_type_cd,
 planned_val_type_descr)
(SELECT 'CSV' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(NULL AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${T_SRC_INPUT_TABLE}' AS filename,
  lang_cd,
  planned_val_role_cd,
  kpi_column_name AS planned_val_type_natural_key,
  planned_val_type_id,
  planning_process_cd,
  key_type_cd AS planned_val_type_key_type_cd,
  planned_val_type_descr
 FROM ldl_data_production_etl.${t_src_input_table} AS src);