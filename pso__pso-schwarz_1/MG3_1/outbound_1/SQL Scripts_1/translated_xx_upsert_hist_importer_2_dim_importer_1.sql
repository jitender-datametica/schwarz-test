
-- SELECT *
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename,
 party_sid, importer_name, importer_nr)
(SELECT dwh_src_file_name,
  0 AS tf_error_fg,
  dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  dwh_src_file_name AS filename,
  party_sid,
  importer_name,
  importer_number
 FROM szd_production_core_rel.t_importer_1);