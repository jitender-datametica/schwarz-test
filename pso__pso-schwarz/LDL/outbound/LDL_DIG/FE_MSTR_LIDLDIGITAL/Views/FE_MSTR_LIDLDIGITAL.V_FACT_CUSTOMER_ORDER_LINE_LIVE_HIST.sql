CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_live_hist (wshop_cd, cust_order_nr,
cust_order_create_dt, cust_order_create_tm, cust_order_dt, prod_variant_sid, prod_qty, prod_price_net_local_val,
prod_price_net_eur_val, is_bundle_header_fg, is_part_of_bundle_header_cnt_fg, is_part_of_bundle_pos_cnt_fg, version_dt)
AS SELECT CUST_ORD.wshop_cd,
 CUST_ORD.cust_order_nr,
 DATE(CUST_ORD.cust_order_create_tmsp) AS cust_order_create_dt,
 CAST(CUST_ORD.cust_order_create_tmsp AS TIME) AS cust_order_create_tm,
 CUST_ORD.cust_order_dt,
 IFNULL(PROD_VAR_REG.prod_variant_sid, - 1) AS prod_variant_sid,
 CUST_ORD.prod_qty,
 CUST_ORD.prod_price_net_local_val,
 SUM(CUST_ORD.prod_price_net_local_val / EX.exchange_rate) AS prod_price_net_eur_val,
 CUST_ORD.is_bundle_header_fg,
 CUST_ORD.is_part_of_bundle_header_cnt_fg,
 CUST_ORD.is_part_of_bundle_pos_cnt_fg,
 CUST_ORD.cust_order_dt AS version_dt
FROM ldl_dig_lec_share.v_fact_customer_order_line AS CUST_ORD
 LEFT JOIN ldl_dig_lec_share.v_rel_product_variant_regional AS PROD_VAR_REG ON CUST_ORD.prod_variant_sid = PROD_VAR_REG
    .prod_variant_sid AND CUST_ORD.wshop_cd = PROD_VAR_REG.wshop_cd AND PROD_VAR_REG.dwh_valid_fg
 LEFT JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS EX ON CUST_ORD.cust_order_dt BETWEEN EX.active_from_dt AND
     EX.active_to_dt AND CUST_ORD.curr_cd = EX.from_curr_cd AND EX.to_curr_cd = 'EUR' AND EX.curr_exchange_rate_type_cd
   = 'F'
WHERE CUST_ORD.is_part_of_bundle_header_cnt_fg
GROUP BY CUST_ORD.wshop_cd,
 CUST_ORD.cust_order_nr,
 cust_order_create_dt,
 cust_order_create_tm,
 CUST_ORD.cust_order_dt,
 prod_variant_sid,
 CUST_ORD.prod_qty,
 CUST_ORD.prod_price_net_local_val,
 CUST_ORD.is_bundle_header_fg,
 CUST_ORD.is_part_of_bundle_header_cnt_fg,
 CUST_ORD.is_part_of_bundle_pos_cnt_fg,
 version_dt;