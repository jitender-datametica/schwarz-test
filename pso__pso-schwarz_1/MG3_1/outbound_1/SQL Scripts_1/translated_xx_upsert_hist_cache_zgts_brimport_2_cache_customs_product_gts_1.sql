
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, papty, prtxt, prvsy, cucoo, etd,
 excise_duty_code, ccngn, ctsmu1)
(SELECT dwh_src_file_name,
  0 AS tf_error_fg,
  dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(COALESCE(etd, etats) AS TIMESTAMP) AS etd_etats,
  dwh_src_file_name AS filename,
  papty,
  prtxt,
  prvsy,
  cucoo,
  COALESCE(etd, etats) AS etd,
  excise_duty_code,
  ccngn,
  ctsmu1
 FROM szd_production_etl.t_cache_zgts_brimport_1
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY ccngn, prvsy, cucoo, papty, COALESCE(etd, etats) ORDER BY 1 IS NULL, 1)) = 1);