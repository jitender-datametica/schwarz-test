
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, consignor_stream_cd,
 product_sid, customs_classification_scheme_cd, origin_country_location_sid, origin_country_name_de,
 origin_iso_country_cd, origin_country_name_en, food_nonfood_type_cd, food_nonfood_type_name,
 customs_tariff_number_descr, alcoholic_beverage_type_cd, customs_tariff_number_cd, alcoholic_beverage_type_name,
 alcoholic_beverage_pct, customs_product_nr, alcoholic_beverage_volume_qty, customs_product_name, parent_product_sid,
 customs_additional_cd, parent_product_name, alcoholic_beverage_duty_per_unit_val, preferential_origin_fg,
 customs_product_type_descr, alcoholic_beverage_tax_rate_cd, customs_product_type_cd)
(SELECT cp.dwh_src_file_name,
  0 AS tf_error_fg,
  cp.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  cp.dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  cp.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  cp.dwh_src_file_name AS filename,
  cp.consignor_stream_cd,
  cp.product_sid,
  COALESCE(ctn.customs_classification_scheme_cd, '-1') AS customs_classification_scheme_cd,
  cp.origin_country_location_sid,
  COALESCE(ctp_de.country_name, 'Unknown') AS origin_country_name_de,
  COALESCE(ctp_de.iso_country_cd, '-1') AS origin_iso_country_cd,
  COALESCE(ctp_en.country_name, 'Unknown') AS origin_country_name_en,
  COALESCE(ctn.food_nonfood_type_cd, '-1') AS food_nonfood_type_cd,
  COALESCE(ctn.food_nonfood_type_name, 'N/A') AS food_nonfood_type_name,
  ctn.customs_tariff_number_descr,
  COALESCE(ctn.alcoholic_beverage_type_cd, '-1') AS alcoholic_beverage_type_cd,
  COALESCE(ctn.customs_tariff_number_cd, '-1') AS customs_tariff_number_cd,
  COALESCE(ctn.alcoholic_beverage_type_name, 'N/A') AS alcoholic_beverage_type_name,
  cp.alcoholic_beverage_pct,
  CAST(COALESCE(ROUND(SAFE_CAST(cp.customs_product_nr AS BIGNUMERIC), 0), -1) AS STRING) AS customs_product_nr,
  cp.alcoholic_beverage_volume_qty,
  cp.customs_product_name,
  COALESCE(p.product_sid, - 1) AS parent_product_sid,
  cp.additional_cd AS customs_additional_cd,
  COALESCE(p.product_name, 'Unknown') AS parent_product_name,
  cp.alcoholic_beverage_duty_per_unit_val,
  cp.preferential_origin_fg,
  cpt.customs_product_type_descr,
  cp.alcoholic_beverage_tax_rate_cd,
  cpt.customs_product_type_cd
 FROM szd_production_core_rel.t_customs_product AS cp
  LEFT JOIN szd_production_core_rel.t_customs_product_type AS cpt ON cp.customs_product_type_cd = cpt.customs_product_type_cd
   
  LEFT JOIN szd_production_core_rel.t_country_political AS ctp_de ON cp.origin_country_location_sid = ctp_de.location_sid
      AND ctp_de.lang_cd = CASE
      WHEN cp.origin_country_location_sid = - 1
      THEN '-1'
      ELSE 'DE'
      END AND ctp_de.dwh_valid_fg
  LEFT JOIN szd_production_core_rel.t_country_political AS ctp_en ON cp.origin_country_location_sid = ctp_en.location_sid
      AND ctp_en.lang_cd = CASE
      WHEN cp.origin_country_location_sid = - 1
      THEN '-1'
      ELSE 'EN'
      END AND ctp_en.dwh_valid_fg
  LEFT JOIN szd_production_core.t_dim_customs_tariff_number AS ctn ON cp.customs_tariff_code_cd = ctn.customs_tariff_number_cd
     AND cp.customs_classification_scheme_cd = ctn.customs_classification_scheme_cd
  LEFT JOIN szd_production_core_rel.t_product AS p ON cp.parent_product_sid = p.product_sid AND p.dwh_valid_fg);