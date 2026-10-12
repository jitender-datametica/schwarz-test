CREATE OR REPLACE VIEW ldl_dig_transfer.v_exp_mis_buac AS WITH ST AS (SELECT wshop_cd,
   target_sale_dt,
   curr_cd,
   SUM(tgt_revenue_net_eur_val) AS tgt_revenue_net_eur_val
  FROM ldl_dig_core.t_fact_sales_target
  GROUP BY wshop_cd,
   target_sale_dt,
   curr_cd), COL AS (SELECT wshop_cd,
   cust_order_dt,
   curr_cd,
   SUM(prod_price_net_local_val) AS prod_price_net_local_val,
   COUNT(DISTINCT cust_order_nr) AS distinct_cust_order_nr,
   ROUND(CAST(SUM(prod_qty) AS BIGNUMERIC), 0) AS prod_qty
  FROM ldl_dig_core.t_fact_customer_order_line
  WHERE (wshop_cd = 'DE' AND is_part_of_bundle_header_cnt_fg OR wshop_cd <> 'DE' AND is_part_of_bundle_pos_cnt_fg)
   AND NOT is_order_cancel_fg
  GROUP BY wshop_cd,
   curr_cd,
   cust_order_dt) (SELECT t1.wshop_cd AS osland,
   t1.target_sale_dt AS bestelldatum,
   t1.curr_cd AS waehrung_konzern,
   ROUND(t6.prod_price_net_local_val / CER.exchange_rate, 2) AS bestellumsatz_nach_storno_nach_phy_retoure,
   t6.distinct_cust_order_nr AS anzahl_bestellungen_nach_storno,
   ROUND(t6.prod_price_net_local_val, 2) AS bestellumsatz_nach_storno_nach_phy_retoure_lw,
   t6.curr_cd AS waehrung_land,
   t6.prod_qty AS bestellmenge_nach_storno_nach_retoure,
   ROUND(t1.tgt_revenue_net_eur_val, 2) AS plan_bestellumsatz,
   t1.curr_cd AS waehrung_plan_bestellumsatz
  FROM ST AS t1
   LEFT JOIN COL AS t6 ON t1.wshop_cd = t6.wshop_cd AND t1.target_sale_dt = t6.cust_order_dt
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate AS CER ON t6.curr_cd = CER.from_curr_cd AND t6.cust_order_dt
       BETWEEN CER.active_from_dt AND CER.active_to_dt AND CER.curr_exchange_rate_type_cd = 'F' AND CER.to_curr_cd =
     'EUR');