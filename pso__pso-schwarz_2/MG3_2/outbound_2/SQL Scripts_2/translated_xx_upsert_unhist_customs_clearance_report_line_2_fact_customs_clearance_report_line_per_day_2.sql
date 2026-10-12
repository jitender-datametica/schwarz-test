
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id, declarant_party_sid,
 customs_product_sid, customs_declaration_type_cd, consignor_party_sid, authority_country_location_sid, duty_paid_val,
 clearance_dt, curr_cd, customs_preference_cd, agreement_sid, origin_country_location_sid, product_cnt,
 transport_country_location_sid, dispatch_country_location_sid, customs_val, net_weight_meas, import_location_sid)
(SELECT ccr.dwh_src_file_name,
  0 AS tf_error_fg,
  ccr.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ccr.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  ccr.dwh_src_file_name AS filename,
  0 AS dwh_load_id,
  COALESCE(ccr.broker_declarant_party_sid, ccr.importer_declarant_party_sid, - 1) AS declarant_party_sid,
  crl.customs_product_sid,
  ccr.customs_declaration_type_cd,
  ccr.consignor_party_sid,
  ccr.authority_country_location_sid,
  SUM(COALESCE(crl.duty_paid_val, 0)) AS duty_paid_val,
  ccr.clearance_dt,
  'GBP' AS curr_cd,
  crl.customs_preference_cd,
  COALESCE(fta.agreement_sid, - 1) AS agreement_sid,
  crl.origin_country_location_sid,
  COUNT(DISTINCT crl.customs_product_sid) AS product_cnt,
  ccr.transport_country_location_sid,
  ccr.dispatch_country_location_sid,
  SUM(COALESCE(crl.customs_val, 0)) AS customs_val,
  SUM(COALESCE(crl.net_mass_qty, 0)) AS net_weight_meas,
  ccr.import_location_sid
 FROM szd_production_core_rel.t_customs_clearance_report_2 AS ccr
  INNER JOIN szd_production_core_rel.t_customs_clearance_report_line_2 AS crl ON ccr.movement_ref_number = crl.movement_ref_number
   
  LEFT JOIN szd_production_core_rel.t_free_trade_agreement_rel_2 AS fta ON crl.origin_country_location_sid = fta.origin_country_location_sid
      AND ccr.authority_country_location_sid = fta.import_country_location_sid AND ccr.clearance_dt BETWEEN CAST(fta.dwh_valid_from_tmsp AS DATE)
    AND (CAST(fta.dwh_valid_to_tmsp AS DATE))
 GROUP BY ccr.clearance_dt,
  ccr.authority_country_location_sid,
  ccr.consignor_party_sid,
  ccr.broker_declarant_party_sid,
  ccr.importer_declarant_party_sid,
  ccr.import_location_sid,
  ccr.customs_declaration_type_cd,
  ccr.dispatch_country_location_sid,
  ccr.transport_country_location_sid,
  crl.origin_country_location_sid,
  crl.customs_product_sid,
  crl.customs_preference_cd,
  fta.agreement_sid,
  ccr.dwh_src_1_tmsp,
  ccr.dwh_src_file_name);