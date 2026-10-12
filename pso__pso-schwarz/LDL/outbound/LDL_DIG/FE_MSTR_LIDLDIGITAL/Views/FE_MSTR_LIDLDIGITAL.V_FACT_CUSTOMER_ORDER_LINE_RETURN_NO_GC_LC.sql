CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_return_no_gc_lc AS SELECT COLR_FACT.wshop_cd
 ,
 IFNULL(COLR_FACT.cust_order_return_sid, - 1) AS cust_order_return_sid,
 COLR_FACT.cust_order_return_nr,
 COLR_FACT.cust_order_return_pos_nr,
 IFNULL(COLR_FACT.cust_order_sid, - 1) AS cust_order_sid,
 COLR_FACT.cust_order_nr,
 COLR_FACT.cust_order_pos_nr,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COLR_FACT.cust_order_return_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS cust_order_return_create_tmsp,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COLR_FACT.cust_order_create_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS cust_order_create_tmsp,
 TIME(COLR_FACT.cust_order_return_create_tmsp) AS cust_order_return_tm,
 TIME(COLR_FACT.cust_order_return_create_tmsp) AS cust_order_return_create_time,
 DATE(COLR_FACT.cust_order_return_create_tmsp) AS cust_order_return_create_date,
 IFNULL(COLR_FACT.prod_variant_sid, - 1) AS prod_variant_sid,
 COLR_FACT.cust_order_dt,
 COLR_FACT.cust_order_return_dt,
 IFNULL(COLR_FACT.cust_sid, - 1) AS cust_sid,
 COLR_FACT.prod_qty AS return_prod_qty,
  CASE
  WHEN COLR_FACT.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(COLR_FACT.curr_cd, '-1')
  END AS curr_cd,
  CASE
  WHEN CER_FACT.to_curr_cd = ''
  THEN '-1'
  ELSE IFNULL(CER_FACT.to_curr_cd, '-1')
  END AS to_curr_cd,
 CER_FACT.exchange_rate,
  CASE
  WHEN CER_FACT.curr_exchange_rate_type_cd = ''
  THEN '-1'
  ELSE IFNULL(CER_FACT.curr_exchange_rate_type_cd, '-1')
  END AS curr_exchange_rate_type_cd,
 CER_FACT.active_from_dt,
 CER_FACT.active_to_dt,
 CER_FACT.active_fg,
  COLR_FACT.prod_price_net_local_val / CER_FACT.exchange_rate AS return_prod_price_net_eur_val,
 COLR_FACT.prod_price_net_local_val,
  COLR_FACT.prod_price_gross_local_val / CER_FACT.exchange_rate AS return_prod_price_gross_eur_val,
 COLR_FACT.prod_price_gross_local_val,
  COLR_FACT.prod_price_vat_local_val / CER_FACT.exchange_rate AS return_prod_price_vat_eur_val,
 COLR_FACT.prod_price_vat_local_val,
  COLR_FACT.prod_coupon_net_local_val / CER_FACT.exchange_rate AS return_prod_coupon_net_eur_val,
 COLR_FACT.prod_coupon_net_local_val,
  COLR_FACT.prod_coupon_gross_local_val / CER_FACT.exchange_rate AS return_prod_coupon_gross_eur_val,
 COLR_FACT.prod_coupon_gross_local_val,
  COLR_FACT.prod_coupon_vat_local_val / CER_FACT.exchange_rate AS return_prod_coupon_vat_eur_val,
 COLR_FACT.prod_coupon_vat_local_val,
  COLR_FACT.delivery_cost_net_local_val / CER_FACT.exchange_rate AS return_delivery_cost_net_eur_val,
 COLR_FACT.delivery_cost_net_local_val,
  COLR_FACT.delivery_cost_gross_local_val / CER_FACT.exchange_rate AS return_delivery_cost_gross_eur_val,
 COLR_FACT.delivery_cost_gross_local_val,
  COLR_FACT.delivery_cost_vat_local_val / CER_FACT.exchange_rate AS return_delivery_cost_vat_eur_val,
 COLR_FACT.delivery_cost_vat_local_val,
  COLR_FACT.delivery_coupon_net_local_val / CER_FACT.exchange_rate AS return_delivery_coupon_net_eur_val,
 COLR_FACT.delivery_coupon_net_local_val,
  COLR_FACT.delivery_coupon_gross_local_val / CER_FACT.exchange_rate AS return_delivery_coupon_gross_eur_val,
 COLR_FACT.delivery_coupon_gross_local_val,
  COLR_FACT.delivery_coupon_vat_local_val / CER_FACT.exchange_rate AS return_delivery_coupon_vat_eur_val,
 COLR_FACT.delivery_coupon_vat_local_val,
  COLR_FACT.delivery_paushal_net_local_val / CER_FACT.exchange_rate AS return_delivery_paushal_net_eur_val,
 COLR_FACT.delivery_paushal_net_local_val,
  COLR_FACT.delivery_paushal_gross_local_val / CER_FACT.exchange_rate AS return_delivery_paushal_gross_eur_val,
 COLR_FACT.delivery_paushal_gross_local_val,
  COLR_FACT.delivery_paushal_vat_local_val / CER_FACT.exchange_rate AS return_delivery_paushal_vat_eur_val,
 COLR_FACT.delivery_paushal_vat_local_val,
  COLR_FACT.delivery_paushal_coupon_net_local_val / CER_FACT.exchange_rate AS return_delivery_paushal_coupon_net_eur_val
 ,
 COLR_FACT.delivery_paushal_coupon_net_local_val,
  COLR_FACT.delivery_paushal_coupon_gross_local_val / CER_FACT.exchange_rate AS
 return_delivery_paushal_coupon_gross_eur_val,
 COLR_FACT.delivery_paushal_coupon_gross_local_val,
  COLR_FACT.delivery_paushal_coupon_vat_local_val / CER_FACT.exchange_rate AS return_delivery_paushal_coupon_vat_eur_val
 ,
 COLR_FACT.delivery_paushal_coupon_vat_local_val,
  COLR_FACT.ivp_price_net_local_val / CER_FACT.exchange_rate AS ivp_price_net_eur_val,
 COLR_FACT.ivp_price_net_local_val,
  COLR_FACT.gld_price_net_local_val / CER_FACT.exchange_rate AS gld_price_net_eur_val,
 COLR_FACT.gld_price_net_local_val,
  COLR_FACT.ivp_original_price_net_local_val / CER_FACT.exchange_rate AS ivp_original_price_net_eur_val,
 COLR_FACT.ivp_original_price_net_local_val,
 COLR_FACT.dropshipment_order_fg,
  CASE
  WHEN COLR_FACT.cust_order_type_cd = ''
  THEN '-1'
  ELSE IFNULL(COLR_FACT.cust_order_type_cd, '-1')
  END AS cust_order_type_cd,
 CAST(NULL AS STRING) AS sales_channel_type_cd,
  CASE
  WHEN COLR_FACT.cust_paym_method_cd = ''
  THEN '-1'
  ELSE IFNULL(COLR_FACT.cust_paym_method_cd, '-1')
  END AS cust_paym_method_cd,
 IFNULL(COLR_FACT.delivery_addr_sid, - 1) AS delivery_addr_sid,
 IFNULL(COLR_FACT.billing_addr_sid, - 1) AS billing_addr_sid,
  CASE
  WHEN COLR_FACT.prod_return_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(COLR_FACT.prod_return_reason_cd, '-1')
  END AS prod_return_reason_cd,
 IFNULL(COLR_FACT.prod_sid, - 1) AS prod_sid,
  CASE
  WHEN COLR_FACT.order_return_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(COLR_FACT.order_return_reason_cd, '-1')
  END AS order_return_reason_cd,
 COL_FACT.wh_sid,
 COLR_FACT.return_wh_sid,
  COLR_FACT.add_services_net_local_val / CER_FACT.exchange_rate AS add_services_net_eur_val,
 COLR_FACT.add_services_net_local_val,
  COLR_FACT.add_services_gross_local_val / CER_FACT.exchange_rate AS add_services_gross_eur_val,
 COLR_FACT.add_services_gross_local_val,
  COLR_FACT.add_services_vat_local_val / CER_FACT.exchange_rate AS add_services_vat_eur_val,
 COLR_FACT.add_services_vat_local_val,
 COLR_FACT.dist_channel_cd,
 COLR_FACT.dist_country_cd,
 COLR_FACT.dist_channel_type_cd
FROM ldl_dig_lec_share.v_fact_customer_return_line AS COLR_FACT
 LEFT JOIN ldl_dig_lec_share.v_fact_customer_order_line AS COL_FACT ON COLR_FACT.cust_order_sid = COL_FACT.cust_order_sid
    AND COLR_FACT.cust_order_pos_nr = COL_FACT.cust_order_pos_nr
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT ON COLR_FACT.curr_cd = CER_FACT.from_curr_cd AND
    COLR_FACT.cust_order_dt BETWEEN CER_FACT.active_from_dt AND CER_FACT.active_to_dt AND CER_FACT.to_curr_cd = 'EUR'
 INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT_DIM ON CER_FACT.curr_exchange_rate_type_cd =
   CERT_DIM.curr_exchange_rate_type_cd AND CERT_DIM.is_general_used_fg
 INNER JOIN ldl_dig_lec_share.v_dim_cal_day AS CAL_DIM ON COLR_FACT.cust_order_return_dt = CAL_DIM.cal_dt AND CAL_DIM.bus_year
    >= 2020;