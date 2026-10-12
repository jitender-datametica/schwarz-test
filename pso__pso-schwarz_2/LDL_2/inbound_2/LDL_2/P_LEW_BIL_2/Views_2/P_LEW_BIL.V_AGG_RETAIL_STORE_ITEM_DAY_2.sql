CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_RETAIL_STORE_ITEM_DAY_2
(
   client_id
  ,store_sid
  ,main_store_sid
  ,item_variant_sid
  ,main_item_sid
  ,cust_sid
  ,cal_dt
  ,curr_cd

  ,turnover_ejr_gross_val
  ,turnover_ejr_py_gross_val
  ,turnover_ejr_py_swday_gross_val
  ,turnover_ejr_net_val
  ,turnover_ejr_py_net_val
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
   agg.item_variant_sid,
   agg.main_item_sid,
   agg.cust_sid,
   agg.cal_dt,
   ex.from_curr_cd                                        AS curr_cd,
   agg.turnover_ejr_gross_val          / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_gross_val,
   agg.turnover_ejr_py_gross_val       / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_gross_val,
   agg.turnover_ejr_py_swday_gross_val / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_swday_gross_val,
   agg.turnover_ejr_net_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_net_val,
   agg.turnover_ejr_py_net_val         / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_net_val,
   agg.turnover_ejr_py_swday_net_val   / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS turnover_ejr_py_swday_net_val,
   agg.sales_ejr_gross_val             / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_gross_val,
   agg.sales_ejr_py_gross_val          / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_gross_val,
   agg.sales_ejr_py_swday_gross_val    / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_swday_gross_val,
   agg.sales_ejr_net_val               / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_net_val,
   agg.sales_ejr_py_net_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_net_val,
   agg.sales_ejr_py_swday_net_val      / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS sales_ejr_py_swday_net_val,
   agg.return_ejr_gross_val            / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_gross_val,
   agg.return_ejr_py_gross_val         / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_gross_val,
   agg.return_ejr_py_swday_gross_val   / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_swday_gross_val,
   agg.return_ejr_net_val              / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_net_val,
   agg.return_ejr_py_net_val           / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_net_val,
   agg.return_ejr_py_swday_net_val     / CASE WHEN ex.exchange_rate = 0 THEN null ELSE ex.exchange_rate END AS return_ejr_py_swday_net_val,
   agg.dwh_load_id,
   agg.dwh_created,
   agg.dwh_updated
   FROM p_lew_bil.t_agg_retail_store_item_day_2 AS agg
   LEFT OUTER JOIN p_lew_bil.t_fact_exchange_rate_2 AS ex
   ON  agg.curr_cd = ex.to_curr_cd
   AND ex.active_fg = 1
   AND ex.exchange_rate_type_cd = '@BEWE'
   ;