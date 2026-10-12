CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_live_master (wshop_cd, cust_order_nr,
cust_order_create_hour, prod_variant_sid, version_dt, lt_relative_dt, prod_price_net_eur_val_today,
prod_price_net_eur_val_avg_by, prod_price_net_eur_val_sdwly, prod_qty_today) AS SELECT wshop_cd,
 cust_order_nr,
 EXTRACT(HOUR FROM cust_order_create_tm) AS cust_order_create_hour,
 prod_variant_sid,
 version_dt,
  CASE
  WHEN cust_order_dt = version_dt
  THEN 'TODAY'
  WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
  THEN 'BY'
  ELSE 'SDWLY'
  END AS lt_relative_dt,
 SUM(CASE
   WHEN CASE
     WHEN cust_order_dt = version_dt
     THEN 'TODAY'
     WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
     THEN 'BY'
     ELSE 'SDWLY'
     END = 'TODAY'
   THEN prod_price_net_eur_val
   ELSE NULL
   END) AS prod_price_net_eur_val_today,
 SUM(CASE
   WHEN CASE
     WHEN cust_order_dt = version_dt
     THEN 'TODAY'
     WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
     THEN 'BY'
     ELSE 'SDWLY'
     END = 'BY'
   THEN prod_price_net_eur_val / (SELECT COUNT(DISTINCT incl_cal_dt) - 1
     FROM ldl_dig_fe_mstr_lidldigital.v_cal_cum_business_year_to_date
     WHERE cal_dt = t_fact_customer_order_line_live.version_dt)
   ELSE NULL
   END) AS prod_price_net_eur_val_avg_by,
 SUM(CASE
   WHEN CASE
     WHEN cust_order_dt = version_dt
     THEN 'TODAY'
     WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
     THEN 'BY'
     ELSE 'SDWLY'
     END = 'SDWLY'
   THEN prod_price_net_eur_val
   ELSE NULL
   END) AS prod_price_net_eur_val_sdwly,
 SUM(CASE
   WHEN CASE
     WHEN cust_order_dt = version_dt
     THEN 'TODAY'
     WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
     THEN 'BY'
     ELSE 'SDWLY'
     END = 'TODAY'
   THEN prod_qty
   ELSE NULL
   END) AS prod_qty_today
FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
WHERE is_part_of_bundle_header_cnt_fg
GROUP BY wshop_cd,
 cust_order_nr,
 cust_order_create_hour,
 prod_variant_sid,
 version_dt,
 lt_relative_dt;