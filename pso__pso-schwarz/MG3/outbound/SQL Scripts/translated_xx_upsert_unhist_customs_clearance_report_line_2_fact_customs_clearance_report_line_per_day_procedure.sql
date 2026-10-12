
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, customs_procedure_cd, dwh_load_id,
 customs_declaration_type_cd, consignor_party_sid, authority_country_location_sid, clearance_dt, declaration_cnt)
(SELECT ccr.dwh_src_file_name,
  0 AS tf_error_fg,
  ccr.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ccr.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  ccr.dwh_src_file_name AS filename,
  crl.customs_procedure_cd,
  0 AS dwh_load_id,
  ccr.customs_declaration_type_cd,
  ccr.consignor_party_sid,
  ccr.authority_country_location_sid,
  ccr.clearance_dt,
  COUNT(DISTINCT crl.movement_ref_number) AS declaration_cnt
 FROM szd_production_core_rel.t_customs_clearance_report AS ccr
  INNER JOIN szd_production_core_rel.t_customs_clearance_report_line AS crl ON ccr.movement_ref_number = crl.movement_ref_number
   
 GROUP BY ccr.authority_country_location_sid,
  ccr.customs_declaration_type_cd,
  ccr.clearance_dt,
  ccr.consignor_party_sid,
  ccr.dwh_src_file_name,
  ccr.dwh_src_1_tmsp,
  crl.customs_procedure_cd);