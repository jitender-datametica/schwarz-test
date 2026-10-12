CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_live (wshop_cd, cust_order_nr,
cust_order_create_dt, cust_order_create_tm, cust_order_dt, prod_variant_sid, prod_qty, prod_price_net_local_val,
prod_price_net_eur_val, is_bundle_header_fg, is_part_of_bundle_header_cnt_fg, is_part_of_bundle_pos_cnt_fg) AS SELECT
 wshop_cd,
 cust_order_nr,
 cust_order_create_dt,
 cust_order_create_tm,
 cust_order_dt,
 IFNULL(prod_variant_sid, - 1) AS `end`,
 prod_qty,
 prod_price_net_local_val,
 prod_price_net_eur_val,
 is_bundle_header_fg,
 is_part_of_bundle_header_cnt_fg,
 is_part_of_bundle_pos_cnt_fg
FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
WHERE is_part_of_bundle_header_cnt_fg
 AND (version_dt = CURRENT_DATE OR version_dt IS NULL);