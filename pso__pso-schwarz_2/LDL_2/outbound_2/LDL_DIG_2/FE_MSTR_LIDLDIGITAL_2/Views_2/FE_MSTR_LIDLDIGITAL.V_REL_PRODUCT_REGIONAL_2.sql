CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_regional_2 (prod_sid, wshop_cd, prod_nr, reg_prod_name,
reg_prod_descr, delivery_src_type_cd, shop_cat_lvl4_sid, shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_name,
shop_cat_lvl2_sid, shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_name, shop_cat_sid, shop_cat_name,
material_pos_type_cd, max_promo_start_dt, tax_class_cd, reg_prod_manager_cd) AS SELECT PREG.prod_sid,
  CASE
  WHEN PREG.wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(PREG.wshop_cd, '-1')
  END AS wshop_cd,
 PREG.prod_nr,
 PREG.reg_prod_name,
 PREG.reg_prod_descr,
  CASE
  WHEN PREG.delivery_src_type_cd = ''
  THEN '-1'
  ELSE IFNULL(PREG.delivery_src_type_cd, '-1')
  END AS delivery_src_type_cd,
 IFNULL(PREG.shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid,
 PREG.shop_cat_lvl4_name,
 IFNULL(PREG.shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 PREG.shop_cat_lvl3_name,
 IFNULL(PREG.shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 PREG.shop_cat_lvl2_name,
 IFNULL(PREG.shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 PREG.shop_cat_lvl1_name,
 IFNULL(PREG.shop_cat_sid, -1) AS shop_cat_sid,
 PREG.shop_cat_name,
  CASE
  WHEN PREG.material_pos_type_cd = ''
  THEN '-1'
  ELSE IFNULL(PREG.material_pos_type_cd, '-1')
  END AS material_pos_type_cd,
 t0.max_promo_start_dt,
 PREG.tax_class_cd,
 PREG.reg_prod_manager_cd
FROM ldl_dig_lec_share.v_rel_product_regional_2 AS PREG
 LEFT JOIN (SELECT prod_sid,
   wshop_cd,
   MAX(promo_start_dt) AS max_promo_start_dt
  FROM ldl_dig_lec_share.v_dim_sales_promotion_2 AS P
  GROUP BY wshop_cd,
   prod_sid) AS t0 ON PREG.prod_sid = t0.prod_sid AND PREG.wshop_cd = t0.wshop_cd
WHERE PREG.dwh_valid_fg;