CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_intercompany_order_line_no_gc_lc (dist_channel_cd,
dist_country_cd, ic_order_sid, ic_order_create_tmsp, ic_order_dt, ic_order_tm, ic_order_create_time,
ic_order_create_date, prod_variant_sid, prod_sid, cust_sid, ic_order_nr, ic_order_pos_nr, prod_qty, delivery_addr_sid,
curr_cd, exchange_rate, curr_exchange_rate_type_cd, curr_exchange_rate_active_from_dt, curr_exchange_rate_active_to_dt,
curr_exchange_rate_active_fg, ivp_price_net_eur_val, ivp_price_net_local_val, cogs_price_net_eur_val,
cogs_price_net_local_val, is_order_cancel_fg, cust_order_perform_dt, cust_delivery_tgt_dt, wh_sid, wh_cd,
prod_variant_nr, prod_nr) AS SELECT ICOL_FACT.dist_channel_cd,
 ICOL_FACT.dist_country_cd,
 IFNULL(ICOL_FACT.ic_order_sid, - 1) AS ic_order_sid,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(ICOL_FACT.ic_order_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS ic_order_create_tmsp,
 ICOL_FACT.ic_order_dt,
 TIME(ICOL_FACT.ic_order_create_tmsp) AS ic_order_tm,
 TIME(ICOL_FACT.ic_order_create_tmsp) AS ic_order_create_time,
 DATE(ICOL_FACT.ic_order_create_tmsp) AS ic_order_create_date,
 IFNULL(ICOL_FACT.prod_variant_sid, - 1) AS prod_variant_sid,
 IFNULL(ICOL_FACT.prod_sid, - 1) AS prod_sid,
 IFNULL(ICOL_FACT.cust_sid, - 1) AS cust_sid,
 ICOL_FACT.ic_order_nr,
 ICOL_FACT.ic_order_pos_nr,
 ICOL_FACT.prod_qty,
 IFNULL(ICOL_FACT.delivery_addr_sid, - 1) AS delivery_addr_sid,
  CASE
  WHEN ICOL_FACT.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(ICOL_FACT.curr_cd, '-1')
  END AS curr_cd,
 CER_FACT.exchange_rate,
  CASE
  WHEN CER_FACT.curr_exchange_rate_type_cd = ''
  THEN '-1'
  ELSE IFNULL(CER_FACT.curr_exchange_rate_type_cd, '-1')
  END AS curr_exchange_rate_type_cd,
 CER_FACT.active_from_dt AS curr_exchange_rate_active_from_dt,
 CER_FACT.active_to_dt AS curr_exchange_rate_active_to_dt,
 CER_FACT.active_fg AS curr_exchange_rate_active_fg,
  ICOL_FACT.ivp_price_net_local_val / CER_FACT.exchange_rate AS ivp_price_net_eur_val,
 ICOL_FACT.ivp_price_net_local_val,
  ICOL_FACT.cogs_price_net_local_val / CER_FACT.exchange_rate AS cogs_price_net_eur_val,
 ICOL_FACT.cogs_price_net_local_val,
 ICOL_FACT.is_order_cancel_fg,
 ICOL_FACT.cust_order_perform_dt,
 ICOL_FACT.cust_delivery_tgt_dt,
 IFNULL(ICOL_FACT.wh_sid, - 1) AS wh_sid,
  CASE
  WHEN ICOL_FACT.wh_cd = ''
  THEN '-1'
  ELSE IFNULL(ICOL_FACT.wh_cd, '-1')
  END AS wh_cd,
 ICOL_FACT.prod_variant_nr,
 ICOL_FACT.prod_nr
FROM ldl_dig_lec_share.v_fact_intercompany_order_line AS ICOL_FACT
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT ON ICOL_FACT.curr_cd = CER_FACT.from_curr_cd AND
    ICOL_FACT.ic_order_dt BETWEEN CER_FACT.active_from_dt AND CER_FACT.active_to_dt AND CER_FACT.to_curr_cd = 'EUR'
 INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT ON CER_FACT.curr_exchange_rate_type_cd = CERT.curr_exchange_rate_type_cd
    AND CERT.is_general_used_fg
 INNER JOIN ldl_dig_lec_share.v_dim_cal_day AS CAL_DIM ON ICOL_FACT.ic_order_dt = CAL_DIM.cal_dt
WHERE CAL_DIM.bus_year_offset IN (0, -1, -2);