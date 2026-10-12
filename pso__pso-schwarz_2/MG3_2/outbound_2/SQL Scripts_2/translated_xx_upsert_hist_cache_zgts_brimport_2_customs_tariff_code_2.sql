
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, customs_tariff_code_cd
 , customs_classification_scheme_cd, customs_tariff_code_descr)
(SELECT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
   ct.dwh_valid_fg <> 0 AS dwh_valid_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.customs_tariff_code_cd,
  ct.customs_classification_scheme_cd,
  CAST(ct.customs_tariff_code_descr AS STRING) AS customs_tariff_code_descr
 FROM (SELECT 'CTC_GB' AS customs_classification_scheme_cd,
    LPAD(SUBSTR(REPLACE(ccngn, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
    NULL AS customs_tariff_code_descr,
    1 AS dwh_valid_fg,
    dwh_src_file_name,
    dwh_src_1_tmsp,
    dwh_src_1_tmsp AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    dwh_src_file_name AS filename
   FROM szd_production_etl.t_cache_zgts_brimport_2
   WHERE ccngn IS NOT NULL) AS ct
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_2 AS cfc ON ct.customs_tariff_code_cd = cfc.customs_tariff_code_cd
   
 WHERE cfc.customs_tariff_code_cd IS NULL);