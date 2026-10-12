CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_1 (prod_sid, prod_nr, prod_name, prod_descr, ian_nr,
ian_nr_artikelabverkauf, prod_hist_nr, prod_brick_cd, prod_packing_type_cd, prod_assortment_class_cd, prod_food_class_cd
, brand_sid, brand_class_cd, prod_storage_cond_cd, prod_dang_good_class_cd, prod_group_cd, import_nr, season_nr,
prod_material_type_cd, prod_promo_class_cd, shop_cat_lvl4_sid, shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_name
, shop_cat_lvl2_sid, shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_name, shop_cat_sid, shop_cat_name,
prod_src_insert_dt, prod_purch_org_type_cd, is_bundle_header_fg, prod_family_cd, prod_subgroup_cd, prod_org_lvl_name,
prod_manager_cd, prod_group_ldt_cd, is_wine_spirits_fg, subcategory_of_need_cd, subcategory_of_need_name,
category_of_need_cd, category_of_need_name, world_of_need_cd, world_of_need_name) AS SELECT prod_sid,
 prod_nr,
 prod_name,
 prod_descr,
 IFNULL(ian_nr, ' ') AS ian_nr,
 IFNULL(ian_nr, 'n/a') AS ian_nr_artikelabverkauf,
 prod_hist_nr,
  CASE
  WHEN prod_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_brick_cd, '-1')
  END AS prod_brick_cd,
  CASE
  WHEN prod_packing_type_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_packing_type_cd, '-1')
  END AS prod_packing_type_cd,
  CASE
  WHEN prod_assortment_class_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_class_cd, '-1')
  END AS prod_assortment_class_cd,
  CASE
  WHEN prod_food_class_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_food_class_cd, '-1')
  END AS prod_food_class_cd,
 IFNULL(brand_sid, -1) AS brand_sid,
  CASE
  WHEN brand_class_cd = ''
  THEN '-1'
  ELSE IFNULL(brand_class_cd, '-1')
  END AS brand_class_cd,
  CASE
  WHEN prod_storage_cond_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_storage_cond_cd, '-1')
  END AS prod_storage_cond_cd,
  CASE
  WHEN prod_dang_good_class_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_dang_good_class_cd, '-1')
  END AS prod_dang_good_class_cd,
  CASE
  WHEN prod_group_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_group_cd, '-1')
  END AS prod_group_cd,
 import_nr,
 season_nr,
  CASE
  WHEN prod_material_type_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_material_type_cd, '-1')
  END AS prod_material_type_cd,
  CASE
  WHEN prod_promo_class_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_promo_class_cd, '-1')
  END AS prod_promo_class_cd,
 IFNULL(shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid,
 shop_cat_lvl4_name,
 IFNULL(shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 shop_cat_lvl3_name,
 IFNULL(shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 shop_cat_lvl2_name,
 IFNULL(shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 shop_cat_lvl1_name,
 IFNULL(shop_cat_sid, -1) AS shop_cat_sid,
 shop_cat_name,
 prod_src_insert_dt,
  CASE
  WHEN prod_purch_org_type_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_purch_org_type_cd, '-1')
  END AS prod_purch_org_type_cd,
 is_bundle_header_fg,
  CASE
  WHEN prod_family_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_family_cd, '-1')
  END AS prod_family_cd,
  CASE
  WHEN prod_subgroup_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_subgroup_cd, '-1')
  END AS prod_subgroup_cd,
  CASE
  WHEN prod_org_lvl_name = ''
  THEN '-1'
  ELSE IFNULL(prod_org_lvl_name, '-1')
  END AS prod_org_lvl_name,
  CASE
  WHEN prod_manager_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_manager_cd, '-1')
  END AS prod_manager_cd,
  CASE
  WHEN prod_group_ldt_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_group_ldt_cd, '-1')
  END AS prod_group_ldt_cd,
 is_wine_spirits_fg,
 subcategory_of_need_cd,
 subcategory_of_need_name,
 category_of_need_cd,
 category_of_need_name,
 world_of_need_cd,
 world_of_need_name
FROM ldl_dig_lec_share.v_dim_product_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 '',
 '',
 'n/a',
 '',
 '-1',
 '-1',
 '-1',
 '-1',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '-1',
 '-1',
 '-1',
 '',
 '',
 '-1',
 '-1',
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
 CAST('-1' AS DATE),
 '-1',
 FALSE,
 '-1',
 '-1',
 '-1',
 '-1',
 '-1',
 FALSE,
 '-1',
 '',
 '-1',
 '',
 '-1',
 '';