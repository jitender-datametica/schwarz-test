CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_variant_promo (prod_variant_sid, prod_variant_nr,
prod_variant_name, prod_variant_descr, prod_sid, prod_nr, prod_name, main_ean_nr, volume_meas, volume_uom_cd, volume_str
, volume_meas_standard, volume_meas_standard_uom_cd, weight_meas, weight_uom_cd, weight_str, weight_meas_standard,
weight_meas_standard_uom_cd, girth_east_meas, girth_west_meas, girth_uom_cd, girth_east_str, girth_east_meas_standard,
girth_west_str, girth_west_meas_standard, girth_meas_standard_uom_cd, length_meas, length_uom_cd, length_str,
length_meas_standard, length_meas_standard_uom_cd, mean_length_meas, mean_length_str, mean_length_meas_standard,
shortest_length_meas, shortest_length_str, shortest_length_meas_standard, longest_length_meas, longest_length_str,
longest_length_meas_standard, width_meas, width_uom_cd, width_str, width_meas_standard, width_meas_standard_uom_cd,
height_meas, height_uom_cd, height_str, height_meas_standard, height_meas_standard_uom_cd, prod_size_type_cd,
is_bulky_item_fg, prod_orig_country_cd, brand_sid, brand_class_cd, prod_assortment_class_cd, prod_global_status_cd,
prod_food_class_cd, palette_capacity_cnt, package_capacity_cnt, container_capacity_cnt, main_supplier_sid, shop_cat_sid
, shop_cat_name, shop_cat_lvl4_sid, shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_name, shop_cat_lvl2_sid,
shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_name, first_inbound_dt, prod_brick_cd, commodity_fg,
is_bundle_header_fg, prod_variant_src_insert_dt, prod_variant_src_update_dt, min_delivery_dt, max_delivery_dt,
promo_dur_week_cnt) AS SELECT PV.prod_variant_sid,
 PV.prod_variant_nr,
 PV.prod_variant_name,
 PV.prod_variant_descr,
 IFNULL(PV.prod_sid, -1) AS prod_sid,
 PV.prod_nr,
 PV.prod_name,
 PV.main_ean_nr,
 PV.volume_meas,
 IFNULL(UOM_VOLUME.uom_cd, '-1') AS volume_uom_cd,
 LEFT(CAST(PV.volume_meas AS STRING) || ' ' || UOM_VOLUME.uom_cd, 20) AS volume_str,
  PV.volume_meas * UOM_VOLUME.uom_standard_multipl_meas AS volume_meas_standard,
 IFNULL(UOM_VOLUME.uom_standard_cd, '-1') AS volume_meas_standard_uom_cd,
 PV.weight_meas,
 IFNULL(UOM_WEIGHT.uom_cd, '-1') AS weight_uom_cd,
 LEFT(CAST(PV.weight_meas AS STRING) || ' ' || UOM_WEIGHT.uom_cd, 20) AS weight_str,
  PV.weight_meas * UOM_WEIGHT.uom_standard_multipl_meas AS weight_meas_standard,
 IFNULL(UOM_WEIGHT.uom_standard_cd, '-1') AS weight_meas_standard_uom_cd,
 PV.girth_east_meas,
 PV.girth_west_meas,
 IFNULL(UOM_GIRTH.uom_cd, '-1') AS girth_uom_cd,
 LEFT(CAST(PV.girth_east_meas AS STRING) || ' ' || UOM_GIRTH.uom_cd, 20) AS girth_east_str,
  PV.girth_east_meas * UOM_GIRTH.uom_standard_multipl_meas AS girth_east_meas_standard,
 LEFT(CAST(PV.girth_west_meas AS STRING) || ' ' || UOM_GIRTH.uom_cd, 20) AS girth_west_str,
  PV.girth_west_meas * UOM_GIRTH.uom_standard_multipl_meas AS girth_west_meas_standard,
 IFNULL(UOM_GIRTH.uom_standard_cd, '-1') AS girth_meas_standard_uom_cd,
 PV.length_meas,
 IFNULL(UOM_LENGTH.uom_cd, '-1') AS length_uom_cd,
 LEFT(CAST(PV.length_meas AS STRING) || ' ' || UOM_LENGTH.uom_cd, 20) AS length_str,
  PV.length_meas * UOM_LENGTH.uom_standard_multipl_meas AS length_meas_standard,
 IFNULL(UOM_LENGTH.uom_standard_cd, '-1') AS length_meas_standard_uom_cd,
 PV.mean_length_meas,
 LEFT(CAST(PV.mean_length_meas AS STRING) || ' ' || UOM_LENGTH.uom_cd, 20) AS mean_length_str,
  PV.mean_length_meas * UOM_LENGTH.uom_standard_multipl_meas AS mean_length_meas_standard,
 PV.shortest_length_meas,
 LEFT(CAST(PV.shortest_length_meas AS STRING) || ' ' || UOM_LENGTH.uom_cd, 20) AS shortest_length_str,
  PV.shortest_length_meas * UOM_LENGTH.uom_standard_multipl_meas AS shortest_length_meas_standard,
 PV.longest_length_meas,
 LEFT(CAST(PV.longest_length_meas AS STRING) || ' ' || UOM_LENGTH.uom_cd, 20) AS longest_length_str,
  PV.longest_length_meas * UOM_LENGTH.uom_standard_multipl_meas AS longest_length_meas_standard,
 PV.width_meas,
 IFNULL(UOM_WIDTH.uom_cd, '-1') AS width_uom_cd,
 LEFT(CAST(PV.width_meas AS STRING) || ' ' || UOM_WIDTH.uom_cd, 20) AS width_str,
  PV.width_meas * UOM_WIDTH.uom_standard_multipl_meas AS width_meas_standard,
 IFNULL(UOM_WIDTH.uom_standard_cd, '-1') AS width_meas_standard_uom_cd,
 PV.height_meas,
 IFNULL(UOM_HEIGHT.uom_cd, '-1') AS height_uom_cd,
 LEFT(CAST(PV.height_meas AS STRING) || ' ' || UOM_HEIGHT.uom_cd, 20) AS height_str,
  PV.height_meas * UOM_HEIGHT.uom_standard_multipl_meas AS height_meas_standard,
 IFNULL(UOM_HEIGHT.uom_standard_cd, '-1') AS height_meas_standard_uom_cd,
  CASE
  WHEN PV.prod_size_type_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_size_type_cd, '-1')
  END AS prod_size_type_cd,
 PV.is_bulky_item_fg,
  CASE
  WHEN PV.prod_orig_country_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_orig_country_cd, '-1')
  END AS prod_orig_country_cd,
 IFNULL(PV.brand_sid, -1) AS brand_sid,
  CASE
  WHEN PV.brand_class_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.brand_class_cd, '-1')
  END AS brand_class_cd,
  CASE
  WHEN PV.prod_assortment_class_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_assortment_class_cd, '-1')
  END AS prod_assortment_class_cd,
  CASE
  WHEN PV.prod_global_status_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_global_status_cd, '-1')
  END AS prod_global_status_cd,
  CASE
  WHEN PV.prod_food_class_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_food_class_cd, '-1')
  END AS prod_food_class_cd,
 PV.palette_capacity_cnt,
 PV.package_capacity_cnt,
 PV.container_capacity_cnt,
 IFNULL(PV.main_supplier_sid, -1) AS main_supplier_sid,
 IFNULL(PV.shop_cat_sid, -1) AS shop_cat_sid,
 PV.shop_cat_name,
 IFNULL(PV.shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid,
 PV.shop_cat_lvl4_name,
 IFNULL(PV.shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 PV.shop_cat_lvl3_name,
 IFNULL(PV.shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 PV.shop_cat_lvl2_name,
 IFNULL(PV.shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 PV.shop_cat_lvl1_name,
 CAST(NULL AS DATE) AS first_inbound_dt,
  CASE
  WHEN PV.prod_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(PV.prod_brick_cd, '-1')
  END AS prod_brick_cd,
  LEFT(CAST(PV.prod_variant_nr AS STRING), 1) = '1' AS commodity_fg,
 PV.is_bundle_header_fg,
 PV.prod_variant_src_insert_dt,
 PV.prod_variant_src_update_dt,
 PV.min_delivery_dt,
 PV.max_delivery_dt,
 PV.promo_dur_week_cnt
FROM ldl_dig_lec_share.v_dim_product_variant_core_view AS PV
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_VOLUME ON UOM_VOLUME.uom_sid = IFNULL(PV.volume_uom_sid
   , -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_WEIGHT ON UOM_WEIGHT.uom_sid = IFNULL(PV.weight_uom_sid
   , -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_GIRTH ON UOM_GIRTH.uom_sid = IFNULL(PV.girth_uom_sid
   , -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_LENGTH ON UOM_LENGTH.uom_sid = IFNULL(PV.length_uom_sid
   , -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_WIDTH ON UOM_WIDTH.uom_sid = IFNULL(PV.width_uom_sid
   , -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_HEIGHT ON UOM_HEIGHT.uom_sid = IFNULL(PV.height_uom_sid
   , -1)
WHERE PV.dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 CAST('0' AS BIGNUMERIC),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 CAST('0' AS BIGNUMERIC),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 CAST('0' AS BIGNUMERIC),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 '',
 '',
 CAST('0' AS BIGNUMERIC),
 '',
 '-1',
 FALSE,
 '-1',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '-1',
 '-1',
 '-1',
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 DATE('1900-01-01'),
 '-1',
 FALSE,
 FALSE,
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 ROUND(CAST('-1' AS BIGNUMERIC), 0);