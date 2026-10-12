CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_retail_store_item_day_1 (client_id, store_sid, main_store_sid, item_variant_sid
, main_item_sid, cust_sid, cal_dt, curr_cd, turnover_ejr_gross_val, turnover_ejr_py_gross_val,
turnover_ejr_py_swday_gross_val, turnover_ejr_net_val, turnover_ejr_py_net_val, turnover_ejr_py_swday_net_val,
sales_ejr_gross_val, sales_ejr_py_gross_val, sales_ejr_py_swday_gross_val, sales_ejr_net_val, sales_ejr_py_net_val,
sales_ejr_py_swday_net_val, return_ejr_gross_val, return_ejr_py_gross_val, return_ejr_py_swday_gross_val,
return_ejr_net_val, return_ejr_py_net_val, return_ejr_py_swday_net_val, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 AGG.client_id,
 AGG.store_sid,
 AGG.main_store_sid,
 AGG.item_variant_sid,
 AGG.main_item_sid,
 AGG.cust_sid,
 AGG.cal_dt,
 EX.from_curr_cd AS curr_cd,
  AGG.turnover_ejr_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_gross_val,
  AGG.turnover_ejr_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_gross_val,
  AGG.turnover_ejr_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_swday_gross_val,
  AGG.turnover_ejr_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_net_val,
  AGG.turnover_ejr_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_net_val,
  AGG.turnover_ejr_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_swday_net_val,
  AGG.sales_ejr_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_gross_val,
  AGG.sales_ejr_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_py_gross_val,
  AGG.sales_ejr_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_py_swday_gross_val,
  AGG.sales_ejr_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_net_val,
  AGG.sales_ejr_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_py_net_val,
  AGG.sales_ejr_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS sales_ejr_py_swday_net_val,
  AGG.return_ejr_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_gross_val,
  AGG.return_ejr_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_py_gross_val,
  AGG.return_ejr_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_py_swday_gross_val,
  AGG.return_ejr_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_net_val,
  AGG.return_ejr_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_py_net_val,
  AGG.return_ejr_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS return_ejr_py_swday_net_val,
 AGG.dwh_load_id,
 AGG.dwh_created,
 AGG.dwh_updated
FROM ldl_p_lew_bil.t_agg_retail_store_item_day_1 AS AGG
 LEFT JOIN ldl_p_lew_bil.t_fact_exchange_rate_1 AS EX ON AGG.curr_cd = EX.to_curr_cd AND EX.active_fg = 1 AND EX.exchange_rate_type_cd
    = '@BEWE';