CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_retail_by_store_day_vs_store_day_product_prev_1d_1 (bus_dt,
int_org_sid, cash_register_net_val, sum_cash_register_net_val, failed, total)
OPTIONS(DESCRIPTION = `TURNOVER FROM PREVIOUS DAY ON STORE LEVEL VS. SUM OF THE TURNOVER ON PRODUCT LEVEL.\\NINPUT DATASETS:\\NCORE_DIM.T_FACT_RETAIL_BY_STORE_DAY_1\\NCORE_DIM.T_FACT_RETAIL_BY_STORE_DAY_PRODUCT_1`)
AS SELECT s.bus_dt,
 s.int_org_sid,
  CASE
  WHEN s.cash_register_sales_net_val IS NULL AND s.cash_register_return_net_val IS NULL
  THEN NULL
  ELSE ROUND(IFNULL(s.cash_register_sales_net_val, 0) + IFNULL(s.cash_register_return_net_val, 0), 2)
  END AS cash_register_net_val,
  CASE
  WHEN t.sum_cash_register_sales_net_val IS NULL AND t.sum_cash_register_return_net_val IS NULL
  THEN NULL
  ELSE ROUND(IFNULL(t.sum_cash_register_sales_net_val, 0) + IFNULL(t.sum_cash_register_return_net_val, 0), 2)
  END AS sum_cash_register_net_val,
  CASE
  WHEN COALESCE(CASE
     WHEN s.cash_register_sales_net_val IS NULL AND s.cash_register_return_net_val IS NULL
     THEN NULL
     ELSE ROUND(IFNULL(s.cash_register_sales_net_val, 0) + IFNULL(s.cash_register_return_net_val, 0), 2)
     END, - 1) <> COALESCE(CASE
     WHEN t.sum_cash_register_sales_net_val IS NULL AND t.sum_cash_register_return_net_val IS NULL
     THEN NULL
     ELSE ROUND(IFNULL(t.sum_cash_register_sales_net_val, 0) + IFNULL(t.sum_cash_register_return_net_val, 0), 2)
     END, - 1)
  THEN 1
  ELSE 0
  END AS failed,
 1 AS total
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_1 AS s
 LEFT JOIN (SELECT bus_dt,
   store_sid,
   SUM(cash_register_sales_net_val) AS sum_cash_register_sales_net_val,
   SUM(cash_register_return_net_val) AS sum_cash_register_return_net_val
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product_1
  GROUP BY bus_dt,
   store_sid) AS t ON s.bus_dt = t.bus_dt AND s.int_org_sid = t.store_sid
WHERE s.bus_dt = DATE_ADD(CURRENT_DATE, INTERVAL - 1 DAY);