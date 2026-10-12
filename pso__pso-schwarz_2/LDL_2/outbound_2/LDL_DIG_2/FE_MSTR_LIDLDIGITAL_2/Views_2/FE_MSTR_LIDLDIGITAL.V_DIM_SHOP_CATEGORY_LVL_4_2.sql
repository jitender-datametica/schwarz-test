CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_shop_category_lvl_4_2 (shop_cat_lvl4_sid, shop_cat_lvl4_cd,
shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_cd, shop_cat_lvl3_name, shop_cat_lvl2_sid, shop_cat_lvl2_cd,
shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_cd, shop_cat_lvl1_name) AS SELECT shop_cat_lvl4_sid,
 IFNULL(shop_cat_lvl4_cd, -1) AS shop_cat_lvl4_cd,
 shop_cat_lvl4_name,
 IFNULL(shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 IFNULL(shop_cat_lvl3_cd, -1) AS shop_cat_lvl3_cd,
 shop_cat_lvl3_name,
 IFNULL(shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 IFNULL(shop_cat_lvl2_cd, -1) AS shop_cat_lvl2_cd,
 shop_cat_lvl2_name,
 IFNULL(shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 IFNULL(shop_cat_lvl1_cd, -1) AS shop_cat_lvl1_cd,
 shop_cat_lvl1_name
FROM ldl_dig_lec_share.v_dim_shop_category_lvl_4_2
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '';