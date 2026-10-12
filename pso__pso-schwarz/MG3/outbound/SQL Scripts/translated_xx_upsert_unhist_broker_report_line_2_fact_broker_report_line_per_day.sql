
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, customs_procedure_cd, dwh_load_id,
 cds_acceptance_dt, broker_declarant_party_sid, total_line_cnt, customs_product_sid, customs_declaration_type_cd,
 consignor_party_sid, alcoholic_line_cnt, non_alcoholic_line_cnt, authority_country_location_sid)
(SELECT MAX(br.dwh_src_file_name),
  0 AS tf_error_fg,
  MAX(br.dwh_src_1_tmsp),
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  MAX(br.dwh_src_1_tmsp) AS dwh_mapping_tmsp,
  MAX(br.dwh_src_file_name) AS filename,
  brl.customs_procedure_cd,
  0 AS dwh_load_id,
  CAST(COALESCE(CAST(br.cds_acceptance_dt AS DATETIME), CAST(br.cds_clearance_dt AS DATETIME), DATE_TRUNC(br.acceptance_tmsp
     ,DD)) AS DATE) AS cds_acceptance_dt,
  br.broker_declarant_party_sid,
  COUNT(*) AS total_line_cnt,
  brl.customs_product_sid,
  br.customs_declaration_type_cd,
  br.consignor_party_sid,
  SUM(CASE
    WHEN rl.customs_tariff_code_type_cd IS NOT NULL
    THEN 1
    ELSE 0
    END) AS alcoholic_line_cnt,
  SUM(CASE
    WHEN rl.customs_tariff_code_type_cd IS NULL
    THEN 1
    ELSE 0
    END) AS non_alcoholic_line_cnt,
  br.authority_country_location_sid
 FROM szd_production_core_rel.t_broker_report AS br
  INNER JOIN szd_production_core_rel.t_broker_report_line AS brl ON br.movement_ref_number = brl.movement_ref_number
  INNER JOIN szd_production_core_rel.t_customs_product AS cp ON brl.customs_product_sid = cp.product_sid AND cp.dwh_valid_fg
   
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_type_rel AS rl ON cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
     AND rl.customs_tariff_category_cd = 'ABV'
 GROUP BY cds_acceptance_dt,
  br.authority_country_location_sid,
  br.broker_declarant_party_sid,
  br.consignor_party_sid,
  br.customs_declaration_type_cd,
  brl.customs_product_sid,
  brl.customs_procedure_cd,
  tf_error_fg,
  dwh_load_id,
  record_id,
  deleted_fg);