CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_product_sales_daily (wshop_cd, cal_dt, prod_sale_type_cd,
prod_set_type_name, prod_sid, prod_nr, prod_name, brand_class_cd, brand_class_descr, delivery_src_type_cd,
delivery_src_type_descr, prod_org_lvl_name, prod_qty, prod_price_net_eur_val, cogs_price_net_eur_val,
return_prod_order_dt_price_net_eur_val, return_prod_order_dt_qty, return_prod_price_net_eur_val, return_prod_qty,
cancel_prod_qty, cancel_prod_price_net_eur_val, cancel_cogs_price_net_eur_val, prod_coupon_net_eur_val,
delivery_paushal_net_eur_val, delivery_paushal_coupon_net_eur_val, delivery_cost_net_eur_val) AS SELECT IFNULL(wshop_cd
  , '-1') AS wshop_cd,
 cal_dt,
 prod_sale_type_cd,
 CAST(CASE
   WHEN is_part_of_bundle_header_cnt_fg AND is_part_of_bundle_pos_cnt_fg
   THEN 'Single Item'
   WHEN is_part_of_bundle_header_cnt_fg AND NOT is_part_of_bundle_pos_cnt_fg
   THEN 'Group Header'
   ELSE 'Group Component'
   END AS STRING) AS prod_set_type_name,
 IFNULL(prod_sid, -1) AS prod_sid,
 prod_nr,
 prod_name,
 IFNULL(brand_class_cd, '-1') AS brand_class_cd,
 brand_class_descr,
 IFNULL(delivery_src_type_cd, '-1') AS delivery_src_type_cd,
 delivery_src_type_descr,
 prod_org_lvl_name,
 prod_qty,
 prod_price_net_eur_val,
 cogs_price_net_eur_val,
 return_prod_order_dt_price_net_eur_val,
 return_prod_order_dt_qty,
 return_prod_price_net_eur_val,
 return_prod_qty,
 cancel_prod_qty,
 cancel_prod_price_net_eur_val,
 cancel_cogs_price_net_eur_val,
 prod_coupon_net_eur_val,
 delivery_paushal_net_eur_val,
 delivery_paushal_coupon_net_eur_val,
 delivery_cost_net_eur_val
FROM ldl_dig_lec_share.v_agg_product_sales_daily;