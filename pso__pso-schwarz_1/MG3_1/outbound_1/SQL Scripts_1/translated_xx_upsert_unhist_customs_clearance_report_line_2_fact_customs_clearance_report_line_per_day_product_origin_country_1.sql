
-- ccr.dwh_src_file_name,
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id,
 customs_product_sid, customs_declaration_type_cd, consignor_party_sid, authority_country_location_sid, duty_paid_val,
 clearance_dt, curr_cd, customs_preference_cd, agreement_sid, declaration_cnt, origin_country_location_sid)
(SELECT MAX(ccr.dwh_src_file_name) AS dwh_src_file_name,
  0 AS tf_error_fg,
  ccr.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ccr.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  MAX(ccr.dwh_src_file_name) AS filename,
  0 AS dwh_load_id,
  crl.customs_product_sid,
  ccr.customs_declaration_type_cd,
  ccr.consignor_party_sid,
  ccr.authority_country_location_sid,
  COALESCE(SUM(crl.duty_paid_val), 0) AS duty_paid_val,
  ccr.clearance_dt,
  'GBP' AS curr_cd,
  crl.customs_preference_cd,
  COALESCE(fta.agreement_sid, - 1) AS agreement_sid,
  COUNT(DISTINCT ccr.movement_ref_number) AS declaration_cnt,
  crl.origin_country_location_sid
 FROM szd_production_core_rel.t_customs_clearance_report_1 AS ccr
  INNER JOIN szd_production_core_rel.t_customs_clearance_report_line_1 AS crl ON ccr.movement_ref_number = crl.movement_ref_number
   /* join SZD_PRODUCTION.core_rel.t_cal_day_1 cd
    on ccr.clearance_dt = cd.cal_dt */
  LEFT JOIN szd_production_core_rel.t_free_trade_agreement_rel_1 AS fta ON ccr.authority_country_location_sid = fta.import_country_location_sid
     AND crl.origin_country_location_sid = fta.origin_country_location_sid
 GROUP BY ccr.authority_country_location_sid,
  ccr.customs_declaration_type_cd,
  ccr.clearance_dt,
  ccr.consignor_party_sid,
  ccr.dwh_src_1_tmsp,
  crl.origin_country_location_sid,
  crl.customs_preference_cd,
  crl.customs_product_sid,
  fta.agreement_sid);