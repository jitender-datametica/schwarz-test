
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, consignor_stream_cd,
 party_sid, importer_party_sid, importer_name, consignor_stream_name, consignor_name, importer_nr, error_descr)
(SELECT DISTINCT c.dwh_src_file_name,
  0 AS tf_error_fg,
  c.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(1 AS BOOL) AS dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  c.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  c.dwh_src_file_name AS filename,
  c.consignor_stream_cd,
  c.party_sid,
  c.importer_party_sid,
  i.importer_name,
  cs.consignor_stream_name,
  c.consignor_name,
  i.importer_number,
  '' AS error_descr
 FROM szd_production_core_rel.t_consignor_1 AS c
  INNER JOIN szd_production_core_rel.t_consignor_stream_1 AS cs ON c.consignor_stream_cd = cs.consignor_stream_cd
  INNER JOIN szd_production_core_rel.t_importer_1 AS i ON c.importer_party_sid = i.party_sid);