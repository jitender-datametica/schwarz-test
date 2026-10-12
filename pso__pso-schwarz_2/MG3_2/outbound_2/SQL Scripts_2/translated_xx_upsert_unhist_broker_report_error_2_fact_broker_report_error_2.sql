
-- SELECT *
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id,
 item_position, attribute_value_txt, declarant_party_sid, cds_acceptance_dt, movement_ref_number, attribute_name)
(SELECT dwh_src_file_name,
  0 AS tf_error_fg,
  dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  dwh_src_1_tmsp AS dwh_mapping_tmsp,
  dwh_src_file_name AS filename,
  0 AS dwh_load_id,
  item_position,
  attribute_value_txt,
  broker_declarant_party_sid,
  cds_acceptance_dt,
  movement_ref_number,
  attribute_name
 FROM szd_production_core_rel.t_broker_report_error_2);