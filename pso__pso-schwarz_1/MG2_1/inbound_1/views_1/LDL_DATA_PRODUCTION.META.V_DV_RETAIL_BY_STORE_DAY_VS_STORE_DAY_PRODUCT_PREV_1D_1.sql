create or replace view LDL_DATA_PRODUCTION.META.V_DV_RETAIL_BY_STORE_DAY_VS_STORE_DAY_PRODUCT_PREV_1D_1(
	BUS_DT,
	INT_ORG_SID,
	CASH_REGISTER_NET_VAL,
	SUM_CASH_REGISTER_NET_VAL,
	FAILED,
	TOTAL
) COMMENT='Turnover from previous day on store level vs. sum of the turnover on product level.\ninput datasets:\ncore_dim.t_fact_retail_by_store_day_1\ncore_dim.t_fact_retail_by_store_day_product_1'
 as SELECT s.bus_dt, s.int_org_sid, CASE WHEN s.cash_register_sales_net_val is null and s.cash_register_return_net_val is null THEN NULL ELSE ROUND(zeroifnull(s.cash_register_sales_net_val) + zeroifnull(s.cash_register_return_net_val), 2) END as cash_register_net_val, CASE WHEN t.sum_cash_register_sales_net_val is null and t.sum_cash_register_return_net_val is null THEN NULL ELSE ROUND(zeroifnull(t.sum_cash_register_sales_net_val) + zeroifnull(t.sum_cash_register_return_net_val), 2) END as sum_cash_register_net_val, CASE WHEN coalesce(cash_register_net_val, -1) <> coalesce(sum_cash_register_net_val, -1) THEN 1 ELSE 0 END AS FAILED, 1 AS TOTAL FROM core_dim.t_fact_retail_by_store_day_1 s LEFT JOIN ( select bus_dt, store_sid, sum(cash_register_sales_net_val) as sum_cash_register_sales_net_val, sum(cash_register_return_net_val) as sum_cash_register_return_net_val from core_dim.t_fact_retail_by_store_day_product_1 group by 1,2 ) t ON t.bus_dt = s.bus_dt AND t.store_sid = s.int_org_sid where s.bus_dt = dateadd(day, -1, current_date());