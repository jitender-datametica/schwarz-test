
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, customs_tariff_code_cd,
 customs_tariff_category_cd, customs_classification_scheme_cd, customs_tariff_code_type_cd)
(SELECT c.dwh_src_file_name,
  0 AS tf_error_fg,
  c.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  c.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  c.dwh_src_file_name AS filename,
  c.customs_tariff_code_cd,
  COALESCE(d.customs_tariff_category_cd, '-1') AS d_customs_tariff_category_cd,
  c.customs_classification_scheme_cd,
  COALESCE(d.customs_tariff_code_type_cd, '-1') AS d_customs_tariff_code_type_cd
 FROM szd_production_core_rel.t_customs_tariff_code_1 AS c
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_type_definition_1 AS d ON c.customs_tariff_code_cd BETWEEN d.lower_bound
   AND d.upper_bound);