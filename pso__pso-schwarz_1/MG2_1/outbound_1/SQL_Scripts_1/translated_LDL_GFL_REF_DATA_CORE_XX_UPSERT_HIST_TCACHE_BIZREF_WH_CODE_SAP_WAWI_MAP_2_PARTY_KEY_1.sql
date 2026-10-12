
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, party_nat_key_nr, party_sid, party_key_type_cd)
(SELECT 'EXTERNAL_CSV' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'EXTERNAL_CSV' AS source_system,
  CURRENT_DATE AS extraction_dt,
  pk.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  CONCAT(wh.land_1, '|', wh.short_name) AS party_nat_key_nr,
  pk.party_sid,
  'COMPANY' AS party_key_type_cd
 FROM ldl_data_production_meta.t_party_key_1 AS pk
  INNER JOIN ldl_data_production_etl.t_tcache_bizref_wh_code_sap_wawi_map AS wh ON REPLACE(pk.party_nat_key_nr, '|', ''
     ) = wh.code AND pk.party_key_type_cd = 'COMPANY');