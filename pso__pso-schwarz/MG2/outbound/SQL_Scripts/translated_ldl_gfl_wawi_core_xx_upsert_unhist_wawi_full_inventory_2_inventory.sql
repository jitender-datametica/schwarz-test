INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 country_org_sid, country_org_cd, int_org_sid, int_org_type_cd, inv_period_start_dt, inv_type_cd, inv_nr,
 inv_period_end_dt, inv_dt, inv_sid)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  country_org_sid,
  ctrcode AS country_org_cd,
  int_org_sid,
  'STORE' AS int_org_type_cd,
  CAST(c182_datefrom AS DATE) AS inv_period_start_dt,
  'FULL' AS inv_type_cd,
  c180_id AS inv_nr,
  CAST(c182_dateuntil AS DATE) AS inv_period_end_dt,
  CAST(c180_inventorydate AS DATE) AS inv_dt,
  inv_sid
 FROM ${temp_db}.t_${src_input_table} AS inv);