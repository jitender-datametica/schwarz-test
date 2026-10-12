
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, lang_cd, party_nat_key_nr, int_org_key_type_cd,
 dispatch_grp_descr, dispatch_grp_nr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  ${load_id} AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  'wawi_precore_dispogruppen' AS filename,
  'WAWI' AS source_system,
  CAST(extraction_tmsp AS DATE) AS extraction_dt,
  CAST(extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
   CASE
   WHEN ctrcode IN ('DE', 'CY', 'CZ', 'GR', 'CH', 'AT', 'BG', 'HR', 'HU', 'LT', 'PT', 'RO')
   THEN 'DE'
   WHEN ctrcode IN ('GB', 'IE', 'NIE', 'LV', 'EE')
   THEN 'EN'
   WHEN ctrcode IN ('CS', 'ES')
   THEN 'ES'
   WHEN ctrcode IN ('CZ')
   THEN 'CS'
   WHEN ctrcode IN ('DK')
   THEN 'DA'
   WHEN ctrcode IN ('FI')
   THEN 'FI'
   WHEN ctrcode IN ('IT')
   THEN 'IT'
   WHEN ctrcode IN ('NL', 'BE')
   THEN 'NL'
   WHEN ctrcode IN ('PL')
   THEN 'PL'
   ELSE 'DE'
   END AS lang_cd,
  ctrcode AS party_nat_key_nr,
  'COUNTRY_2' AS int_org_key_type_cd,
  dispogrupbez AS dispatch_grp_descr,
  CAST(dispogrupnr AS STRING) AS dispatch_grp_nr
 FROM ldl_data_production_etl.t_wawi_precore_dispogruppen_2);