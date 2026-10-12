




INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_sid, tax_class_cd, bus_dt
 , country_org_sid, geo_area_sid, store_sid, country_org_cd, curr_cd, turnover_gross_val, vat_val, stat_dt, curr_stat_fg
 , vat_stat_calc_method_cd)
(SELECT 'TXJ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'TXJ',
  CURRENT_DATE,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  src.real_estate_sid,
  src.tax_class_cd,
  src.bus_dt,
  src.country_org_sid,
  src.geo_area_sid,
  src.store_sid,
  COALESCE(org.country_org_cd, '-1') AS org_country_org_cd,
  COALESCE(org.curr_cd, '-1') AS org_curr_cd,
  src.turnover_gross_val,
  src.vat_val,
  src.stat_dt,
  src.curr_stat_fg,
  src.vat_stat_calc_method_cd
 FROM ${temp_db}.${t_src_input_table} AS src
  LEFT JOIN ${target_db}.t_internal_organization AS org ON src.country_org_sid = org.int_org_sid AND src.bus_dt BETWEEN CAST(org.dwh_valid_from_tmsp AS DATE)
    AND (CAST(org.dwh_valid_to_tmsp AS DATE)));