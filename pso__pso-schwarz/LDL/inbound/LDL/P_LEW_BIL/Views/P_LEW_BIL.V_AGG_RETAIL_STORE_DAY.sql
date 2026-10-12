CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_RETAIL_STORE_DAY
(
   client_id
  ,store_sid
  ,main_store_sid
  ,cal_dt
  ,curr_cd

  ,receipt_cnt
  ,receipt_kpges_cnt
  ,receipt_kpges_plan_cnt
  ,receipt_wawi_cnt
  ,receipt_txj_cnt
  ,receipt_ejr_cnt
  ,receipt_py_cnt
  ,receipt_kpges_py_cnt
  ,receipt_kpges_py_plan_cnt
  ,receipt_wawi_py_cnt
  ,receipt_txj_py_cnt
  ,receipt_ejr_py_cnt
  ,receipt_py_swday_cnt
  ,receipt_kpges_py_swday_cnt
  ,receipt_kpges_py_swday_plan_cnt
  ,receipt_wawi_py_swday_cnt
  ,receipt_txj_py_swday_cnt
  ,receipt_ejr_py_swday_cnt

  ,turnover_gross_val
  ,turnover_wawi_gross_val
  ,turnover_txj_gross_val
  ,turnover_ejr_gross_val
  ,turnover_py_gross_val
  ,turnover_wawi_py_gross_val
  ,turnover_txj_py_gross_val
  ,turnover_ejr_py_gross_val
  ,turnover_py_swday_gross_val
  ,turnover_wawi_py_swday_gross_val
  ,turnover_txj_py_swday_gross_val
  ,turnover_ejr_py_swday_gross_val
  ,turnover_net_val
  ,turnover_kpges_net_val
  ,turnover_kpges_plan_net_val
  ,turnover_wawi_net_val
  ,turnover_txj_net_val
  ,turnover_ejr_net_val
  ,turnover_py_net_val
  ,turnover_kpges_py_net_val
  ,turnover_kpges_py_plan_net_val
  ,turnover_wawi_py_net_val
  ,turnover_txj_py_net_val
  ,turnover_ejr_py_net_val
  ,turnover_py_swday_net_val
  ,turnover_kpges_py_swday_net_val
  ,turnover_kpges_py_swday_plan_net_val
  ,turnover_wawi_py_swday_net_val
  ,turnover_txj_py_swday_net_val
  ,turnover_ejr_py_swday_net_val

  ,sales_ejr_gross_val
  ,sales_ejr_py_gross_val
  ,sales_ejr_py_swday_gross_val
  ,sales_ejr_net_val
  ,sales_ejr_py_net_val
  ,sales_ejr_py_swday_net_val
  ,return_ejr_gross_val
  ,return_ejr_py_gross_val
  ,return_ejr_py_swday_gross_val
  ,return_ejr_net_val
  ,return_ejr_py_net_val
  ,return_ejr_py_swday_net_val

  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
)
AS

   SELECT
      agg.client_id,
   agg.store_sid,
   agg.main_store_sid,
   agg.cal_dt,
   ex.from_curr_cd                                                         AS curr_cd,
   agg.receipt_cnt,
   agg.receipt_kpges_cnt,
   agg.receipt_kpges_plan_cnt,
   agg.receipt_wawi_cnt,
   agg.receipt_txj_cnt,
   agg.receipt_ejr_cnt,
   agg.receipt_py_cnt,
   agg.receipt_kpges_py_cnt,
   agg.receipt_kpges_py_plan_cnt,
   agg.receipt_wawi_py_cnt,
   agg.receipt_txj_py_cnt,
   agg.receipt_ejr_py_cnt,
   agg.receipt_py_swday_cnt,
   agg.receipt_kpges_py_swday_cnt,
   agg.receipt_kpges_py_swday_plan_cnt,
   agg.receipt_wawi_py_swday_cnt,
   agg.receipt_txj_py_swday_cnt,
   agg.receipt_ejr_py_swday_cnt,
   agg.turnover_gross_val                   / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_gross_val,
   agg.turnover_wawi_gross_val              / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_gross_val,
   agg.turnover_txj_gross_val               / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_gross_val,
   agg.turnover_ejr_gross_val               / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_gross_val,
   agg.turnover_py_gross_val                / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_py_gross_val,
   agg.turnover_wawi_py_gross_val           / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_py_gross_val,
   agg.turnover_txj_py_gross_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_py_gross_val,
   agg.turnover_ejr_py_gross_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_gross_val,
   agg.turnover_py_swday_gross_val          / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_py_swday_gross_val,
   agg.turnover_wawi_py_swday_gross_val     / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_py_swday_gross_val,
   agg.turnover_txj_py_swday_gross_val      / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_py_swday_gross_val,
   agg.turnover_ejr_py_swday_gross_val      / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_swday_gross_val,
   agg.turnover_net_val                     / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_net_val,
   agg.turnover_kpges_net_val               / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_net_val,
   agg.turnover_kpges_plan_net_val          / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_plan_net_val,
   agg.turnover_wawi_net_val                / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_net_val,
   agg.turnover_txj_net_val                 / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_net_val,
   agg.turnover_ejr_net_val                 / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_net_val,
   agg.turnover_py_net_val                  / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_py_net_val,
   agg.turnover_kpges_py_net_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_py_net_val,
   agg.turnover_kpges_py_plan_net_val       / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_py_plan_net_val,
   agg.turnover_wawi_py_net_val             / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_py_net_val,
   agg.turnover_txj_py_net_val              / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_py_net_val,
   agg.turnover_ejr_py_net_val              / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_net_val,
   agg.turnover_py_swday_net_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_py_swday_net_val,
   agg.turnover_kpges_py_swday_net_val      / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_py_swday_net_val,
   agg.turnover_kpges_py_swday_plan_net_val / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_kpges_py_swday_plan_net_val,
   agg.turnover_wawi_py_swday_net_val       / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_wawi_py_swday_net_val,
   agg.turnover_txj_py_swday_net_val        / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_txj_py_swday_net_val,
   agg.turnover_ejr_py_swday_net_val        / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_swday_net_val,
   agg.sales_ejr_gross_val                  / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_gross_val,
   agg.sales_ejr_py_gross_val               / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_gross_val,
   agg.sales_ejr_py_swday_gross_val         / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_swday_gross_val,
   agg.sales_ejr_net_val                    / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_net_val,
   agg.sales_ejr_py_net_val                 / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_net_val,
   agg.sales_ejr_py_swday_net_val           / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_swday_net_val,
   agg.return_ejr_gross_val                 / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_gross_val,
   agg.return_ejr_py_gross_val              / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_gross_val,
   agg.return_ejr_py_swday_gross_val        / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_swday_gross_val,
   agg.return_ejr_net_val                   / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_net_val,
   agg.return_ejr_py_net_val                / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_net_val,
   agg.return_ejr_py_swday_net_val          / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_swday_net_val,
   agg.dwh_load_id,
   agg.dwh_created,
   agg.dwh_updated
   FROM p_lew_bil.t_agg_retail_store_day AS agg
   LEFT OUTER JOIN p_lew_bil.t_fact_exchange_rate AS ex
   ON  agg.curr_cd = ex.to_curr_cd
   AND ex.active_fg = 1
   AND ex.exchange_rate_type_cd = '@BEWE'
   ;