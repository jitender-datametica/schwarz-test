
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, lang_cd, int_org_key_type_cd,
 order_area_nr, int_org_nk, order_area_descr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_HQ' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'DE' AS lang_cd,
  'COUNTRY_1' AS int_org_key_type_cd,
  bestbereichnr AS order_area_nr,
  ctrcode AS int_org_nk,
  bestbereichbez AS order_area_descr
 FROM ${temp_db}.${t_src_input_table} AS src);