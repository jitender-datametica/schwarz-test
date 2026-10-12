
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, lang_cd, party_nat_key_nr,
 dispatch_grp_descr, dispatch_grp_nr, int_org_key_type_cd)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  ${load_id} AS dwh_load_id,
  'WAWI' AS source_system,
  CAST(extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'wawi_precore_dispogruppen' AS filename,
   CASE
   WHEN wawi_instanz_kzl IN ('DE', 'CY', 'CZ', 'GR', 'CH', 'AT', 'BG', 'HR', 'HU', 'LT', 'PT', 'RO')
   THEN 'DE'
   WHEN wawi_instanz_kzl IN ('GB', 'IE', 'NIE', 'LV', 'EE')
   THEN 'EN'
   WHEN wawi_instanz_kzl IN ('CS', 'ES')
   THEN 'ES'
   WHEN wawi_instanz_kzl IN ('CZ')
   THEN 'CS'
   WHEN wawi_instanz_kzl IN ('DK')
   THEN 'DA'
   WHEN wawi_instanz_kzl IN ('FI')
   THEN 'FI'
   WHEN wawi_instanz_kzl IN ('IT')
   THEN 'IT'
   WHEN wawi_instanz_kzl IN ('NL', 'BE')
   THEN 'NL'
   WHEN wawi_instanz_kzl IN ('PL')
   THEN 'PL'
   ELSE 'DE'
   END AS lang_cd,
   CASE
   WHEN wawi_instanz_kzl = 'CS'
   THEN 'ES'
   ELSE LEFT(wawi_instanz_kzl, 2)
   END AS party_nat_key_nr,
  dispogrupbez AS dispatch_grp_descr,
  CAST(dispogrupnr AS STRING) AS dispatch_grp_nr,
  'COUNTRY' AS int_org_key_type_cd
 FROM whwawiadm.dispogruppen
 WHERE delete_fg IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CASE
        WHEN wawi_instanz_kzl = 'CS'
        THEN 'ES'
        ELSE LEFT(wawi_instanz_kzl, 2)
        END, dispogrupnr ORDER BY extraction_tmsp IS NULL DESC, extraction_tmsp DESC)) = 1);


