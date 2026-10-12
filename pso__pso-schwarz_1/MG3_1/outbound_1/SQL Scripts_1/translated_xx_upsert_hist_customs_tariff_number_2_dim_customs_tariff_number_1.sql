
-- SELECT *
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id,
 customs_classification_scheme_cd, food_nonfood_type_cd, food_nonfood_type_name, customs_tariff_number_descr,
 alcoholic_beverage_type_cd, customs_tariff_number_cd, alcoholic_beverage_type_name)
(SELECT ctc.dwh_src_file_name,
  0 AS tf_error_fg,
  ctc.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ctc.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  ctc.dwh_src_file_name AS filename,
  0 AS dwh_load_id,
  'CTC_GB' AS customs_classification_scheme_cd,
  COALESCE(MAX(food.customs_tariff_code_type_cd), '-1') AS food_customs_tariff_code_type_cd,
  COALESCE(MAX(food.customs_tariff_code_type_name), 'N/A') AS food_customs_tariff_code_type_name,
  ctc.customs_tariff_code_descr AS customs_tariff_number_descr,
  COALESCE(MAX(abv.customs_tariff_code_type_cd), '-1') AS abv_customs_tariff_code_type_cd,
  ctc.customs_tariff_code_cd AS customs_tariff_number_cd,
  COALESCE(MAX(abv.customs_tariff_code_type_name), 'N/A') AS abv_customs_tariff_code_type_name
 FROM szd_production_core_rel.t_customs_tariff_code_1 AS ctc
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_type_rel_1 AS rel ON ctc.customs_tariff_code_cd = rel.customs_tariff_code_cd
   
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_type_1 AS food ON rel.customs_tariff_code_type_cd = food.customs_tariff_code_type_cd
      AND rel.customs_tariff_category_cd = food.customs_tariff_category_cd AND food.customs_tariff_category_cd = 'F/NF'
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_type_1 AS abv ON rel.customs_tariff_code_type_cd = abv.customs_tariff_code_type_cd
      AND rel.customs_tariff_category_cd = abv.customs_tariff_category_cd AND abv.customs_tariff_category_cd = 'ABV'
 GROUP BY customs_tariff_number_cd,
  customs_tariff_number_descr,
  dwh_mapping_tmsp,
  ctc.dwh_src_file_name,
  ctc.dwh_src_1_tmsp,
  record_id);