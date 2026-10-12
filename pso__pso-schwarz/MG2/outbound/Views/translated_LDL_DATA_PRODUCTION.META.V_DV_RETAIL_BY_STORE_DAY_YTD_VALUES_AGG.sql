CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_retail_by_store_day_ytd_values_agg (bus_dt, cal_dt, bus_year,
int_org_sid, int_org_type_cd, country_org_cd, sales_cnt, sales_bytd_cnt, agg_sales_cnt, sales_py_cnt, sales_py_bytd_cnt
, sales_py_swday_cnt, sales_py_swday_bytd_cnt, sales_qty, sales_bytd_qty, agg_sales_qty, sales_py_qty, sales_py_bytd_qty
, sales_py_swday_qty, sales_py_swday_bytd_qty, return_cnt, return_bytd_cnt, agg_return_cnt, return_py_cnt,
return_py_bytd_cnt, return_py_swday_cnt, return_py_swday_bytd_cnt, return_qty, return_bytd_qty, agg_return_qty,
return_py_qty, return_py_bytd_qty, return_py_swday_qty, return_py_swday_bytd_qty, perf_adj_sales_cnt,
perf_adj_sales_bytd_cnt, agg_perf_adj_sales_cnt, perf_adj_sales_py_cnt, perf_adj_sales_py_bytd_cnt,
perf_adj_sales_py_swday_cnt, perf_adj_sales_py_swday_bytd_cnt, perf_adj_sales_qty, perf_adj_sales_bytd_qty,
agg_perf_adj_sales_qty, perf_adj_sales_py_qty, perf_adj_sales_py_bytd_qty, perf_adj_sales_py_swday_qty,
perf_adj_sales_py_swday_bytd_qty, perf_adj_return_cnt, perf_adj_return_bytd_cnt, agg_perf_adj_return_cnt,
perf_adj_return_py_cnt, perf_adj_return_py_bytd_cnt, perf_adj_return_py_swday_cnt, perf_adj_return_py_swday_bytd_cnt,
perf_adj_return_qty, perf_adj_return_bytd_qty, agg_perf_adj_return_qty, perf_adj_return_py_qty,
perf_adj_return_py_bytd_qty, perf_adj_return_py_swday_qty, perf_adj_return_py_swday_bytd_qty, uom_cd, turnover_net_val,
turnover_bytd_net_val, agg_turnover_net_val, turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val,
turnover_py_swday_bytd_net_val, plan_turnover_net_val, plan_turnover_bytd_net_val, agg_plan_turnover_net_val,
plan_turnover_py_net_val, plan_turnover_py_bytd_net_val, plan_turnover_py_swday_net_val,
plan_turnover_py_swday_bytd_net_val, cash_register_sales_net_val, cash_register_sales_bytd_net_val,
agg_cash_register_sales_net_val, cash_register_sales_py_net_val, cash_register_sales_py_bytd_net_val,
cash_register_sales_py_swday_net_val, cash_register_sales_py_swday_bytd_net_val, cash_register_return_net_val,
cash_register_return_bytd_net_val, agg_cash_register_return_net_val, cash_register_return_py_net_val,
cash_register_return_py_bytd_net_val, cash_register_return_py_swday_net_val, cash_register_return_py_swday_bytd_net_val
, eod_turnover_net_val, booked_turnover_net_val, turnover_gross_val, turnover_bytd_gross_val, agg_turnover_gross_val,
turnover_py_gross_val, turnover_py_bytd_gross_val, turnover_py_swday_gross_val, turnover_py_swday_bytd_gross_val,
cash_register_sales_gross_val, cash_register_return_gross_val, eod_turnover_gross_val, curr_cd, receipt_cnt,
receipt_bytd_cnt, agg_receipt_cnt, receipt_py_cnt, receipt_py_bytd_cnt, receipt_py_swday_cnt, receipt_py_swday_bytd_cnt
, cash_register_receipt_cnt, eod_receipt_cnt, booked_receipt_cnt, plan_receipt_cnt, plan_receipt_bytd_cnt,
agg_plan_receipt_cnt, plan_receipt_py_cnt, plan_receipt_py_bytd_cnt, plan_receipt_py_swday_cnt,
plan_receipt_py_swday_bytd_cnt, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd,
failed_turnover_bytd_net_val, failed_plan_turnover_bytd_net_val, failed_turnover_bytd_gross_val, failed_receipt_bytd_cnt
, failed_plan_receipt_bytd_cnt, failed_sales_bytd_cnt, failed_sales_bytd_qty, failed_return_bytd_cnt,
failed_return_bytd_qty, failed_perf_adj_sales_bytd_cnt, failed_perf_adj_sales_bytd_qty, failed_perf_adj_return_bytd_cnt
, failed_perf_adj_return_bytd_qty, failed_cash_register_sales_bytd_net_val, failed_cash_register_return_bytd_net_val,
total)
OPTIONS(DESCRIPTION = `RETAIL BY STORE AND DAY TOGETHER WITH AGGREGATED REVENUES (BUSINESS YEAR TO DATE) TO CHECK, IF BYTD COLUMNS ARE CALCULATED CORRECTLY\\NINPUT DATASETS:\\NCORE_DIM.T_FACT_RETAIL_BY_STORE_DAY\\NCORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_DATE`)
AS SELECT fact.bus_dt,
 dt.cal_dt,
 dt.bus_year,
 fact.int_org_sid,
 fact.int_org_type_cd,
 fact.country_org_cd,
 fact.sales_cnt,
 fact.sales_bytd_cnt,
 SUM(fact.sales_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt
    IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_sales_cnt,
 fact.sales_py_cnt,
 fact.sales_py_bytd_cnt,
 fact.sales_py_swday_cnt,
 fact.sales_py_swday_bytd_cnt,
 fact.sales_qty,
 fact.sales_bytd_qty,
 SUM(fact.sales_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt
    IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_sales_qty,
 fact.sales_py_qty,
 fact.sales_py_bytd_qty,
 fact.sales_py_swday_qty,
 fact.sales_py_swday_bytd_qty,
 fact.return_cnt,
 fact.return_bytd_cnt,
 SUM(fact.return_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt
    IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_return_cnt,
 fact.return_py_cnt,
 fact.return_py_bytd_cnt,
 fact.return_py_swday_cnt,
 fact.return_py_swday_bytd_cnt,
 fact.return_qty,
 fact.return_bytd_qty,
 SUM(fact.return_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt
    IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_return_qty,
 fact.return_py_qty,
 fact.return_py_bytd_qty,
 fact.return_py_swday_qty,
 fact.return_py_swday_bytd_qty,
 fact.perf_adj_sales_cnt,
 fact.perf_adj_sales_bytd_cnt,
 SUM(fact.perf_adj_sales_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_perf_adj_sales_cnt,
 fact.perf_adj_sales_py_cnt,
 fact.perf_adj_sales_py_bytd_cnt,
 fact.perf_adj_sales_py_swday_cnt,
 fact.perf_adj_sales_py_swday_bytd_cnt,
 fact.perf_adj_sales_qty,
 fact.perf_adj_sales_bytd_qty,
 SUM(fact.perf_adj_sales_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_perf_adj_sales_qty,
 fact.perf_adj_sales_py_qty,
 fact.perf_adj_sales_py_bytd_qty,
 fact.perf_adj_sales_py_swday_qty,
 fact.perf_adj_sales_py_swday_bytd_qty,
 fact.perf_adj_return_cnt,
 fact.perf_adj_return_bytd_cnt,
 SUM(fact.perf_adj_return_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_perf_adj_return_cnt,
 fact.perf_adj_return_py_cnt,
 fact.perf_adj_return_py_bytd_cnt,
 fact.perf_adj_return_py_swday_cnt,
 fact.perf_adj_return_py_swday_bytd_cnt,
 fact.perf_adj_return_qty,
 fact.perf_adj_return_bytd_qty,
 SUM(fact.perf_adj_return_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_perf_adj_return_qty,
 fact.perf_adj_return_py_qty,
 fact.perf_adj_return_py_bytd_qty,
 fact.perf_adj_return_py_swday_qty,
 fact.perf_adj_return_py_swday_bytd_qty,
 fact.uom_cd,
 fact.turnover_net_val,
 fact.turnover_bytd_net_val,
 SUM(fact.turnover_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_turnover_net_val,
 fact.turnover_py_net_val,
 fact.turnover_py_bytd_net_val,
 fact.turnover_py_swday_net_val,
 fact.turnover_py_swday_bytd_net_val,
 fact.plan_turnover_net_val,
 fact.plan_turnover_bytd_net_val,
 SUM(fact.plan_turnover_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING)
  ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 agg_plan_turnover_net_val,
 fact.plan_turnover_py_net_val,
 fact.plan_turnover_py_bytd_net_val,
 fact.plan_turnover_py_swday_net_val,
 fact.plan_turnover_py_swday_bytd_net_val,
 fact.cash_register_sales_net_val,
 fact.cash_register_sales_bytd_net_val,
 SUM(fact.cash_register_sales_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING)
  ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 agg_cash_register_sales_net_val,
 fact.cash_register_sales_py_net_val,
 fact.cash_register_sales_py_bytd_net_val,
 fact.cash_register_sales_py_swday_net_val,
 fact.cash_register_sales_py_swday_bytd_net_val,
 fact.cash_register_return_net_val,
 fact.cash_register_return_bytd_net_val,
 SUM(fact.cash_register_return_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING)
    ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 agg_cash_register_return_net_val,
 fact.cash_register_return_py_net_val,
 fact.cash_register_return_py_bytd_net_val,
 fact.cash_register_return_py_swday_net_val,
 fact.cash_register_return_py_swday_bytd_net_val,
 fact.eod_turnover_net_val,
 fact.booked_turnover_net_val,
 fact.turnover_gross_val,
 fact.turnover_bytd_gross_val,
 SUM(fact.turnover_gross_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_turnover_gross_val,
 fact.turnover_py_gross_val,
 fact.turnover_py_bytd_gross_val,
 fact.turnover_py_swday_gross_val,
 fact.turnover_py_swday_bytd_gross_val,
 fact.cash_register_sales_gross_val,
 fact.cash_register_return_gross_val,
 fact.eod_turnover_gross_val,
 fact.curr_cd,
 fact.receipt_cnt,
 fact.receipt_bytd_cnt,
 SUM(fact.receipt_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt
    IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_receipt_cnt,
 fact.receipt_py_cnt,
 fact.receipt_py_bytd_cnt,
 fact.receipt_py_swday_cnt,
 fact.receipt_py_swday_bytd_cnt,
 fact.cash_register_receipt_cnt,
 fact.eod_receipt_cnt,
 fact.booked_receipt_cnt,
 fact.plan_receipt_cnt,
 fact.plan_receipt_bytd_cnt,
 SUM(fact.plan_receipt_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING), CAST(dt.bus_year AS STRING) ORDER BY
    fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_plan_receipt_cnt,
 fact.plan_receipt_py_cnt,
 fact.plan_receipt_py_bytd_cnt,
 fact.plan_receipt_py_swday_cnt,
 fact.plan_receipt_py_swday_bytd_cnt,
 fact.dwh_created_tmsp,
 fact.dwh_updated_tmsp,
 fact.dwh_load_id,
 fact.dwh_node_cd,
  CASE
  WHEN COALESCE(fact.turnover_bytd_net_val, - 1) <> COALESCE(SUM(fact.turnover_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_turnover_bytd_net_val,
  CASE
  WHEN COALESCE(fact.plan_turnover_bytd_net_val, - 1) <> COALESCE(SUM(fact.plan_turnover_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_plan_turnover_bytd_net_val,
  CASE
  WHEN COALESCE(fact.turnover_bytd_gross_val, - 1) <> COALESCE(SUM(fact.turnover_gross_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_turnover_bytd_gross_val,
  CASE
  WHEN COALESCE(fact.receipt_bytd_cnt, - 1) <> COALESCE(SUM(fact.receipt_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_receipt_bytd_cnt,
  CASE
  WHEN COALESCE(fact.plan_receipt_bytd_cnt, - 1) <> COALESCE(SUM(fact.plan_receipt_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_plan_receipt_bytd_cnt,
  CASE
  WHEN COALESCE(fact.sales_bytd_cnt, - 1) <> COALESCE(SUM(fact.sales_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_sales_bytd_cnt,
  CASE
  WHEN COALESCE(fact.sales_bytd_qty, - 1) <> COALESCE(SUM(fact.sales_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_sales_bytd_qty,
  CASE
  WHEN COALESCE(fact.return_bytd_cnt, - 1) <> COALESCE(SUM(fact.return_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_return_bytd_cnt,
  CASE
  WHEN COALESCE(fact.return_bytd_qty, - 1) <> COALESCE(SUM(fact.return_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_return_bytd_qty,
  CASE
  WHEN COALESCE(fact.perf_adj_sales_bytd_cnt, - 1) <> COALESCE(SUM(fact.perf_adj_sales_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_perf_adj_sales_bytd_cnt,
  CASE
  WHEN COALESCE(fact.perf_adj_sales_bytd_qty, - 1) <> COALESCE(SUM(fact.perf_adj_sales_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_perf_adj_sales_bytd_qty,
  CASE
  WHEN COALESCE(fact.perf_adj_return_bytd_cnt, - 1) <> COALESCE(SUM(fact.perf_adj_return_cnt) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_perf_adj_return_bytd_cnt,
  CASE
  WHEN COALESCE(fact.perf_adj_return_bytd_qty, - 1) <> COALESCE(SUM(fact.perf_adj_return_qty) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_perf_adj_return_bytd_qty,
  CASE
  WHEN COALESCE(fact.cash_register_sales_bytd_net_val, - 1) <> COALESCE(SUM(fact.cash_register_sales_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_cash_register_sales_bytd_net_val,
  CASE
  WHEN COALESCE(fact.cash_register_return_bytd_net_val, - 1) <> COALESCE(SUM(fact.cash_register_return_net_val) OVER (PARTITION BY CAST(fact.int_org_sid AS STRING)
       , CAST(dt.bus_year AS STRING) ORDER BY fact.bus_dt IS NULL, fact.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW), - 1)
  THEN 1
  ELSE 0
  END AS failed_cash_register_return_bytd_net_val,
 1 AS total
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day AS fact
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date AS dt ON fact.bus_dt = dt.cal_dt
WHERE fact.bus_dt < CURRENT_DATE
ORDER BY fact.int_org_sid NULLS LAST,
 fact.bus_dt NULLS LAST;