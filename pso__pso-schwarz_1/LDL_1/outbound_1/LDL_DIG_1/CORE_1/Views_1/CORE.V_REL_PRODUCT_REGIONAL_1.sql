CREATE OR REPLACE VIEW ldl_dig_core.v_rel_product_regional_1 AS SELECT PREG.wshop_cd,
 PREG.prod_sid,
 PREG.dwh_valid_from_tmsp,
 PREG.dwh_valid_to_tmsp,
 PREG.dwh_valid_fg,
 PREG.prod_nr,
 PREG.reg_prod_name,
 PREG.reg_prod_descr,
 PREG.delivery_src_type_cd,
 PREG.material_pos_type_cd,
 PREG.shop_cat_sid,
 PREG.shop_cat_name,
 PREG.shop_cat_lvl4_sid,
 PREG.shop_cat_lvl4_name,
 PREG.shop_cat_lvl3_sid,
 PREG.shop_cat_lvl3_name,
 PREG.shop_cat_lvl2_sid,
 PREG.shop_cat_lvl2_name,
 PREG.shop_cat_lvl1_sid,
 PREG.shop_cat_lvl1_name,
 t0.max_promo_start_dt
FROM ldl_dig_core.t_rel_product_regional_1 AS PREG
 LEFT JOIN (SELECT prod_sid,
   wshop_cd,
   MAX(promo_start_dt) AS max_promo_start_dt
  FROM ldl_dig_core.t_dim_sales_promotion_1 AS P
  GROUP BY wshop_cd,
   prod_sid) AS t0 ON PREG.prod_sid = t0.prod_sid AND PREG.wshop_cd = t0.wshop_cd;