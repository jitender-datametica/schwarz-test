CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_retail_store_day_2 (client_id, store_sid, main_store_sid, cal_dt, curr_cd,
receipt_cnt, receipt_kpges_cnt, receipt_kpges_plan_cnt, receipt_wawi_cnt, receipt_txj_cnt, receipt_ejr_cnt,
receipt_py_cnt, receipt_kpges_py_cnt, receipt_kpges_py_plan_cnt, receipt_wawi_py_cnt, receipt_txj_py_cnt,
receipt_ejr_py_cnt, receipt_py_swday_cnt, receipt_kpges_py_swday_cnt, receipt_kpges_py_swday_plan_cnt,
receipt_wawi_py_swday_cnt, receipt_txj_py_swday_cnt, receipt_ejr_py_swday_cnt, turnover_gross_val,
turnover_wawi_gross_val, turnover_txj_gross_val, turnover_ejr_gross_val, turnover_py_gross_val,
turnover_wawi_py_gross_val, turnover_txj_py_gross_val, turnover_ejr_py_gross_val, turnover_py_swday_gross_val,
turnover_wawi_py_swday_gross_val, turnover_txj_py_swday_gross_val, turnover_ejr_py_swday_gross_val, turnover_net_val,
turnover_kpges_net_val, turnover_kpges_plan_net_val, turnover_wawi_net_val, turnover_txj_net_val, turnover_ejr_net_val,
turnover_py_net_val, turnover_kpges_py_net_val, turnover_kpges_py_plan_net_val, turnover_wawi_py_net_val,
turnover_txj_py_net_val, turnover_ejr_py_net_val, turnover_py_swday_net_val, turnover_kpges_py_swday_net_val,
turnover_kpges_py_swday_plan_net_val, turnover_wawi_py_swday_net_val, turnover_txj_py_swday_net_val,
turnover_ejr_py_swday_net_val, sales_ejr_gross_val, sales_ejr_py_gross_val, sales_ejr_py_swday_gross_val,
sales_ejr_net_val, sales_ejr_py_net_val, sales_ejr_py_swday_net_val, return_ejr_gross_val, return_ejr_py_gross_val,
return_ejr_py_swday_gross_val, return_ejr_net_val, return_ejr_py_net_val, return_ejr_py_swday_net_val, dwh_load_id,
dwh_created, dwh_updated) AS SELECT AGG.client_id,
 AGG.store_sid,
 AGG.main_store_sid,
 AGG.cal_dt,
 EX.from_curr_cd AS curr_cd,
 AGG.receipt_cnt,
 AGG.receipt_kpges_cnt,
 AGG.receipt_kpges_plan_cnt,
 AGG.receipt_wawi_cnt,
 AGG.receipt_txj_cnt,
 AGG.receipt_ejr_cnt,
 AGG.receipt_py_cnt,
 AGG.receipt_kpges_py_cnt,
 AGG.receipt_kpges_py_plan_cnt,
 AGG.receipt_wawi_py_cnt,
 AGG.receipt_txj_py_cnt,
 AGG.receipt_ejr_py_cnt,
 AGG.receipt_py_swday_cnt,
 AGG.receipt_kpges_py_swday_cnt,
 AGG.receipt_kpges_py_swday_plan_cnt,
 AGG.receipt_wawi_py_swday_cnt,
 AGG.receipt_txj_py_swday_cnt,
 AGG.receipt_ejr_py_swday_cnt,
  AGG.turnover_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_gross_val,
  AGG.turnover_wawi_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_gross_val,
  AGG.turnover_txj_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_gross_val,
  AGG.turnover_ejr_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_gross_val,
  AGG.turnover_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_py_gross_val,
  AGG.turnover_wawi_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_py_gross_val,
  AGG.turnover_txj_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_py_gross_val,
  AGG.turnover_ejr_py_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_gross_val,
  AGG.turnover_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_py_swday_gross_val,
  AGG.turnover_wawi_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_py_swday_gross_val,
  AGG.turnover_txj_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_py_swday_gross_val,
  AGG.turnover_ejr_py_swday_gross_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_swday_gross_val,
  AGG.turnover_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_net_val,
  AGG.turnover_kpges_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_net_val,
  AGG.turnover_kpges_plan_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_plan_net_val,
  AGG.turnover_wawi_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_net_val,
  AGG.turnover_txj_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_net_val,
  AGG.turnover_ejr_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_net_val,
  AGG.turnover_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_py_net_val,
  AGG.turnover_kpges_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_py_net_val,
  AGG.turnover_kpges_py_plan_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_py_plan_net_val,
  AGG.turnover_wawi_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_py_net_val,
  AGG.turnover_txj_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_py_net_val,
  AGG.turnover_ejr_py_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_ejr_py_net_val,
  AGG.turnover_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_py_swday_net_val,
  AGG.turnover_kpges_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_py_swday_net_val,
  AGG.turnover_kpges_py_swday_plan_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_kpges_py_swday_plan_net_val,
  AGG.turnover_wawi_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_wawi_py_swday_net_val,
  AGG.turnover_txj_py_swday_net_val / CASE
   WHEN EX.exchange_rate = 0
   THEN NULL
   ELSE EX.exchange_rate
   END AS turnover_txj_py_swday_net_val,
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
FROM ldl_p_lew_bil.t_agg_retail_store_day_2 AS AGG
 LEFT JOIN ldl_p_lew_bil.t_fact_exchange_rate_2 AS EX ON AGG.curr_cd = EX.to_curr_cd AND EX.active_fg = 1 AND EX.exchange_rate_type_cd
    = '@BEWE';