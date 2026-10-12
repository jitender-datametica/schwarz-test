CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_live_test (wshop_cd, cust_order_nr,
prod_variant_sid, lt_relative_dt, cust_order_create_hour, prod_price_net_eur_val_today, prod_price_net_eur_val_avg_by,
prod_price_net_eur_val_sdwly, prod_price_net_eur_val_avg_by_curr_hour, prod_price_net_eur_val_sdwly_curr_hour) AS SELECT
 wshop_cd,
 cust_order_nr,
 prod_variant_sid,
  CASE
  WHEN cust_order_dt = version_dt
  THEN 'TODAY'
  WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
  THEN 'BY'
  ELSE 'SDWLY'
  END AS lt_relative_dt,
 EXTRACT(HOUR FROM cust_order_create_tm) AS cust_order_create_hour,
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
      END = 'BY' AND EXTRACT(HOUR FROM cust_order_create_tm) <= (SELECT MAX(CASE
         WHEN cust_order_dt = version_dt
         THEN EXTRACT(HOUR FROM cust_order_create_tm)
         ELSE NULL
         END)
      FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
      WHERE is_part_of_bundle_header_cnt_fg
       AND version_dt = CURRENT_DATE)
   THEN prod_price_net_eur_val / (SELECT COUNT(DISTINCT incl_cal_dt) - 1
     FROM ldl_dig_fe_mstr_lidldigital.v_cal_cum_business_year_to_date
     WHERE cal_dt = t_fact_customer_order_line_live.version_dt)
   ELSE NULL
   END) AS prod_price_net_eur_val_avg_by_curr_hour,
 SUM(CASE
   WHEN CASE
      WHEN cust_order_dt = version_dt
      THEN 'TODAY'
      WHEN cust_order_dt = DATE_ADD(version_dt, INTERVAL - 1 DAY)
      THEN 'BY'
      ELSE 'SDWLY'
      END = 'SDWLY' AND EXTRACT(HOUR FROM cust_order_create_tm) <= (SELECT MAX(CASE
         WHEN cust_order_dt = version_dt
         THEN EXTRACT(HOUR FROM cust_order_create_tm)
         ELSE NULL
         END)
      FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
      WHERE is_part_of_bundle_header_cnt_fg
       AND version_dt = CURRENT_DATE)
   THEN prod_price_net_eur_val
   ELSE NULL
   END) AS prod_price_net_eur_val_sdwly_curr_hour
FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
WHERE is_part_of_bundle_header_cnt_fg
 AND version_dt = CURRENT_DATE
GROUP BY wshop_cd,
 cust_order_nr,
 prod_variant_sid,
 lt_relative_dt,
 cust_order_create_hour;