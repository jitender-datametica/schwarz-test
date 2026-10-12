
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id, declarant_party_sid,
 customs_declaration_type_cd, consignor_party_sid, authority_country_location_sid, duty_paid_val, clearance_dt, curr_cd
 , declaration_cnt, transport_country_location_sid, dispatch_country_location_sid, import_location_sid, excise_val)
(SELECT ccr.dwh_src_file_name,
  0 AS tf_error_fg,
  ccr.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ccr.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  ccr.dwh_src_file_name AS filename,
  0 AS dwh_load_id,
  COALESCE(ccr.broker_declarant_party_sid, ccr.importer_declarant_party_sid, - 1) AS declarant_party_sid,
  ccr.customs_declaration_type_cd,
  ccr.consignor_party_sid,
  ccr.authority_country_location_sid,
  SUM(COALESCE(crl.duty_paid_val, 0)) AS duty_paid_val,
  ccr.clearance_dt,
  'GBP' AS curr_cd,
  COUNT(DISTINCT ccr.movement_ref_number) AS declaration_cnt,
  ccr.transport_country_location_sid,
  ccr.dispatch_country_location_sid,
  ccr.import_location_sid,
  SUM(CASE
    WHEN crl.item_position = 1
    THEN COALESCE(ccr.total_excise_val, 0)
    ELSE 0
    END) AS excise_val
 FROM szd_production_core_rel.t_customs_clearance_report_1 AS ccr
  INNER JOIN szd_production_core_rel.t_customs_clearance_report_line_1 AS crl ON ccr.movement_ref_number = crl.movement_ref_number
   
 GROUP BY ccr.clearance_dt,
  ccr.authority_country_location_sid,
  ccr.consignor_party_sid,
  ccr.broker_declarant_party_sid,
  ccr.importer_declarant_party_sid,
  ccr.import_location_sid,
  ccr.customs_declaration_type_cd,
  ccr.dispatch_country_location_sid,
  ccr.transport_country_location_sid,
  ccr.dwh_src_file_name,
  ccr.dwh_src_1_tmsp);