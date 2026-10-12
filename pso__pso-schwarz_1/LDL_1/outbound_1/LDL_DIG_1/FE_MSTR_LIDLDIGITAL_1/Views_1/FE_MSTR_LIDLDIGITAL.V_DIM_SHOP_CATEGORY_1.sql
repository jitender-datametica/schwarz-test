CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_shop_category_1 (shop_cat_sid, shop_cat_cd, shop_cat_name,
shop_cat_lvl1_sid, shop_cat_lvl2_sid, shop_cat_lvl3_sid, shop_cat_lvl4_sid) AS SELECT shop_cat_sid,
 IFNULL(shop_cat_cd, -1) AS shop_cat_cd,
 shop_cat_name,
 IFNULL(shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 IFNULL(shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 IFNULL(shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 IFNULL(shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid
FROM ldl_dig_lec_share.v_dim_shop_category_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0);