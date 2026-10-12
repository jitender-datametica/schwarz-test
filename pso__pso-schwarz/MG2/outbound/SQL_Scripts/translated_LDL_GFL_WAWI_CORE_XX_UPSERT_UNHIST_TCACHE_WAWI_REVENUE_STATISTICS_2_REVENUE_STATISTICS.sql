
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_sid, bus_dt,
 country_org_sid, store_sid, country_org_cd, curr_cd, turnover_gross_val, stat_dt, curr_stat_fg, receipt_line_nr,
 turnover_net_val, receipt_nr, stat_src_cd, revenue_stat_type_id, correction_seq, receipt_cnt)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  src.bus_dt AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  src.real_estate_sid,
  src.bus_dt,
  src.country_org_sid,
  src.store_sid,
  org.country_org_cd,
  org.curr_cd,
  src.turnover_gross_val,
  src.stat_dt,
  src.curr_stat_fg,
  src.receipt_line_nr,
  src.turnover_net_val,
  src.receipt_nr,
  src.stat_src_cd,
  src.revenue_stat_type_id,
  src.correction_seq,
  src.receipt_cnt
 FROM ${temp_db}.${t_src_input_table} AS src
  LEFT JOIN ${target_db}.t_internal_organization AS org ON src.country_org_sid = org.int_org_sid AND src.bus_dt BETWEEN CAST(org.dwh_valid_from_tmsp AS DATE)
    AND (CAST(org.dwh_valid_to_tmsp AS DATE)));