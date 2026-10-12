CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_customs_product_1 (product_sid,
sales_variant_product_group_sid, customs_product_type_cd, customs_product_type_descr, origin_country_location_sid,
consignor_stream_cd, origin_iso_country_cd, origin_country_name_de, origin_country_name_en, customs_product_nr,
customs_additional_cd, customs_additional_cd1, customs_classification_scheme_cd, customs_tariff_number_cd,
customs_tariff_number_descr, food_nonfood_type_cd, food_nonfood_type_name, alcoholic_beverage_tax_rate_cd,
alcoholic_beverage_type_cd, alcoholic_beverage_type_name, alcoholic_beverage_volume_qty, alcoholic_beverage_pct,
alcoholic_beverage_duty_per_unit_val, customs_product_name, preferential_origin_fg, parent_product_sid,
parent_product_name, dwh_valid_from_tmsp, dwh_valid_to_tmsp) AS SELECT product_sid,
 sales_variant_product_group_sid,
 customs_product_type_cd,
 customs_product_type_descr,
 origin_country_location_sid,
 consignor_stream_cd,
 origin_iso_country_cd,
 origin_country_name_de,
 origin_country_name_en,
  CASE
  WHEN customs_additional_cd <> ''
  THEN CAST(customs_product_nr AS STRING) || '_' || customs_additional_cd
  ELSE CAST(customs_product_nr AS STRING)
  END AS customs_product_nr,
  CASE
  WHEN LENGTH(customs_additional_cd) > 0
  THEN '_' || customs_additional_cd
  ELSE customs_additional_cd
  END AS customs_additional_cd,
 customs_additional_cd AS customs_additional_cd1,
 customs_classification_scheme_cd,
 customs_tariff_number_cd,
 customs_tariff_number_descr,
 food_nonfood_type_cd,
 food_nonfood_type_name,
 alcoholic_beverage_tax_rate_cd,
 alcoholic_beverage_type_cd,
 alcoholic_beverage_type_name,
 alcoholic_beverage_volume_qty,
 alcoholic_beverage_pct,
 alcoholic_beverage_duty_per_unit_val,
 customs_product_name,
 preferential_origin_fg,
 parent_product_sid,
 parent_product_name,
 DATE(dwh_valid_from_tmsp) AS dwh_valid_from_tmsp,
 DATE(dwh_valid_to_tmsp) AS dwh_valid_to_tmsp
FROM szd_production_core.t_dim_customs_product_1;