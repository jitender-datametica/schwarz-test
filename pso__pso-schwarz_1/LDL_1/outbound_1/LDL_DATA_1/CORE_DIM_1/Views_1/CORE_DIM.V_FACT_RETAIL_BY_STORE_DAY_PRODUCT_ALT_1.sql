CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_retail_by_store_day_product_alt_1 (bus_dt, store_sid, prod_sid,
sales_variant_sid, country_org_sid, country_org_cd, total_cnt, total_qty, uom_cd, turnover_net_val, turnover_gross_val,
curr_cd, turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val,
turnover_py_swday_bytd_net_val, sales_net_val, sales_bytd_net_val, sales_py_net_val, sales_py_bytd_net_val,
sales_py_swday_net_val, sales_py_swday_bytd_net_val, return_net_val, return_bytd_net_val, return_py_net_val,
return_py_bytd_net_val, return_py_swday_net_val, return_py_swday_bytd_net_val, sales_cnt, sales_bytd_cnt, sales_py_cnt,
sales_py_bytd_cnt, sales_py_swday_cnt, sales_py_swday_bytd_cnt, sales_qty, sales_bytd_qty, sales_py_qty,
sales_py_bytd_qty, sales_py_swday_qty, sales_py_swday_bytd_qty, return_cnt, return_bytd_cnt, return_py_cnt,
return_py_bytd_cnt, return_py_swday_cnt, return_py_swday_bytd_cnt, return_qty, return_bytd_qty, return_py_qty,
return_py_bytd_qty, return_py_swday_qty, return_py_swday_bytd_qty, perf_adj_total_cnt, perf_adj_total_bytd_cnt,
perf_adj_total_py_cnt, perf_adj_total_py_bytd_cnt, perf_adj_total_py_swday_cnt, perf_adj_total_py_swday_bytd_cnt,
perf_adj_total_qty, perf_adj_total_bytd_qty, perf_adj_total_py_qty, perf_adj_total_py_bytd_qty,
perf_adj_total_py_swday_qty, perf_adj_total_py_swday_bytd_qty, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id,
dwh_node_cd) AS SELECT F_TSDP.bus_dt,
 F_TSDP.store_sid,
 F_TSDP.prod_sid,
 F_TSDP.sales_variant_sid,
 F_TSDP.country_org_sid,
 F_TSDP.country_org_cd,
  COALESCE(F_TSDP.sales_cnt, 0) + COALESCE(F_TSDP.return_cnt, 0) AS total_cnt,
  COALESCE(F_TSDP.sales_qty, 0) + COALESCE(F_TSDP.return_qty, 0) AS total_qty,
 F_TSDP.uom_cd,
  COALESCE(F_TSDP.cash_register_sales_net_val, 0) + COALESCE(F_TSDP.cash_register_return_net_val, 0) AS turnover_net_val
 ,
  COALESCE(F_TSDP.cash_register_sales_gross_val, 0) + COALESCE(F_TSDP.cash_register_return_gross_val, 0) AS
 turnover_gross_val,
 F_TSDP.curr_cd,
 SUM(COALESCE(F_TSDP.cash_register_sales_net_val, 0) + COALESCE(F_TSDP.cash_register_return_net_val, 0)) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING)
    , CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING), CAST(F_TSDP.sales_variant_sid AS STRING),
    F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt IS NULL, F_TSDP.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val,
 f_tsdp_py.turnover_net_val AS turnover_py_net_val,
 f_tsdp_py.turnover_bytd_net_val AS turnover_py_bytd_net_val,
 f_tsdp_py_swday.turnover_net_val AS turnover_py_swday_net_val,
 f_tsdp_py_swday.turnover_bytd_net_val AS turnover_py_swday_bytd_net_val,
 F_TSDP.cash_register_sales_net_val AS sales_net_val,
 SUM(F_TSDP.cash_register_sales_net_val) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING)
    , CAST(F_TSDP.prod_sid AS STRING), CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd,
    F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 sales_bytd_net_val,
 f_tsdp_py.sales_net_val AS sales_py_net_val,
 f_tsdp_py.sales_bytd_net_val AS sales_py_bytd_net_val,
 f_tsdp_py_swday.sales_net_val AS sales_py_swday_net_val,
 f_tsdp_py_swday.sales_bytd_net_val AS sales_py_swday_bytd_net_val,
 F_TSDP.cash_register_return_net_val AS return_net_val,
 SUM(F_TSDP.cash_register_return_net_val) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING)
    , CAST(F_TSDP.prod_sid AS STRING), CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd,
    F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 return_bytd_net_val,
 f_tsdp_py.return_net_val AS return_py_net_val,
 f_tsdp_py.return_bytd_net_val AS return_py_bytd_net_val,
 f_tsdp_py_swday.return_net_val AS return_py_swday_net_val,
 f_tsdp_py_swday.return_bytd_net_val AS return_py_swday_bytd_net_val,
 F_TSDP.sales_cnt,
 SUM(F_TSDP.sales_cnt) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING)
    , CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt
    IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
 f_tsdp_py.sales_cnt AS sales_py_cnt,
 f_tsdp_py.sales_bytd_cnt AS sales_py_bytd_cnt,
 f_tsdp_py_swday.sales_cnt AS sales_py_swday_cnt,
 f_tsdp_py_swday.sales_bytd_cnt AS sales_py_swday_bytd_cnt,
 F_TSDP.sales_qty,
 SUM(F_TSDP.sales_qty) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING)
    , CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt
    IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
 f_tsdp_py.sales_qty AS sales_py_qty,
 f_tsdp_py.sales_bytd_qty AS sales_py_bytd_qty,
 f_tsdp_py_swday.sales_qty AS sales_py_swday_qty,
 f_tsdp_py_swday.sales_bytd_qty AS sales_py_swday_bytd_qty,
 F_TSDP.return_cnt,
 SUM(F_TSDP.return_cnt) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING)
    , CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt
    IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
 f_tsdp_py.return_cnt AS return_py_cnt,
 f_tsdp_py.return_bytd_cnt AS return_py_bytd_cnt,
 f_tsdp_py_swday.return_cnt AS return_py_swday_cnt,
 f_tsdp_py_swday.return_bytd_cnt AS return_py_swday_bytd_cnt,
 F_TSDP.return_qty,
 SUM(F_TSDP.return_qty) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING), CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING)
    , CAST(F_TSDP.sales_variant_sid AS STRING), F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt
    IS NULL, F_TSDP.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
 f_tsdp_py.return_qty AS return_py_qty,
 f_tsdp_py.return_bytd_qty AS return_py_bytd_qty,
 f_tsdp_py_swday.return_qty AS return_py_swday_qty,
 f_tsdp_py_swday.return_bytd_qty AS return_py_swday_bytd_qty,
  COALESCE(F_TSDP.perf_adj_sales_cnt, 0) + COALESCE(F_TSDP.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
 SUM(COALESCE(F_TSDP.perf_adj_sales_cnt, 0) + COALESCE(F_TSDP.perf_adj_return_cnt, 0)) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING)
    , CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING), CAST(F_TSDP.sales_variant_sid AS STRING),
    F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt IS NULL, F_TSDP.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_cnt,
 f_tsdp_py.perf_adj_total_cnt AS perf_adj_total_py_cnt,
 f_tsdp_py.perf_adj_total_bytd_cnt AS perf_adj_total_py_bytd_cnt,
 f_tsdp_py_swday.perf_adj_total_cnt AS perf_adj_total_py_swday_cnt,
 f_tsdp_py_swday.perf_adj_total_bytd_cnt AS perf_adj_total_py_swday_bytd_cnt,
  COALESCE(F_TSDP.perf_adj_sales_qty, 0) + COALESCE(F_TSDP.perf_adj_return_qty, 0) AS perf_adj_total_qty,
 SUM(COALESCE(F_TSDP.perf_adj_sales_qty, 0) + COALESCE(F_TSDP.perf_adj_return_qty, 0)) OVER (PARTITION BY CAST(D_CD.bus_year AS STRING)
    , CAST(F_TSDP.store_sid AS STRING), CAST(F_TSDP.prod_sid AS STRING), CAST(F_TSDP.sales_variant_sid AS STRING),
    F_TSDP.country_org_cd, F_TSDP.uom_cd, F_TSDP.curr_cd ORDER BY F_TSDP.bus_dt IS NULL, F_TSDP.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_qty,
 f_tsdp_py.perf_adj_total_qty AS perf_adj_total_py_qty,
 f_tsdp_py.perf_adj_total_bytd_qty AS perf_adj_total_py_bytd_qty,
 f_tsdp_py_swday.perf_adj_total_qty AS perf_adj_total_py_swday_qty,
 f_tsdp_py_swday.perf_adj_total_bytd_qty AS perf_adj_total_py_swday_bytd_qty,
 F_TSDP.dwh_created_tmsp,
 F_TSDP.dwh_updated_tmsp,
 F_TSDP.dwh_load_id,
 F_TSDP.dwh_node_cd
FROM ldl_data_core_dim.t_fact_retail_by_store_day_product_1 AS F_TSDP
 INNER JOIN ldl_data_core_dim.t_dim_calendar_date_1 AS D_CD ON F_TSDP.bus_dt = D_CD.cal_dt
 LEFT JOIN (SELECT SUB1.bus_dt,
   SUB1.store_sid,
   SUB1.prod_sid,
   SUB1.sales_variant_sid,
   SUB1.country_org_sid,
   SUB1.country_org_cd,
   SUB1.uom_cd,
   SUB1.curr_cd,
    COALESCE(SUB1.cash_register_sales_net_val, 0) + COALESCE(SUB1.cash_register_return_net_val, 0) AS turnover_net_val,
   SUM(COALESCE(SUB1.cash_register_sales_net_val, 0) + COALESCE(SUB1.cash_register_return_net_val, 0)) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING)
      , CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING), CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd
      , SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS turnover_bytd_net_val,
   SUB1.cash_register_sales_net_val AS sales_net_val,
   SUM(SUB1.cash_register_sales_net_val) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING)
      , CAST(SUB1.prod_sid AS STRING), CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd
      ORDER BY SUB1.bus_dt IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_net_val
   ,
   SUB1.cash_register_return_net_val AS return_net_val,
   SUM(SUB1.cash_register_return_net_val) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING)
      , CAST(SUB1.prod_sid AS STRING), CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd
      ORDER BY SUB1.bus_dt IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_net_val
   ,
   SUB1.sales_cnt,
   SUM(SUB1.sales_cnt) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING)
      , CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt
      IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
   SUB1.sales_qty,
   SUM(SUB1.sales_qty) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING)
      , CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt
      IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
   SUB1.return_cnt,
   SUM(SUB1.return_cnt) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING)
      , CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt
      IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
   SUB1.return_qty,
   SUM(SUB1.return_qty) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING), CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING)
      , CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd, SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt
      IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
    COALESCE(SUB1.perf_adj_sales_cnt, 0) + COALESCE(SUB1.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
   SUM(COALESCE(SUB1.perf_adj_sales_cnt, 0) + COALESCE(SUB1.perf_adj_return_cnt, 0)) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING)
      , CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING), CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd
      , SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS perf_adj_total_bytd_cnt,
    COALESCE(SUB1.perf_adj_sales_qty, 0) + COALESCE(SUB1.perf_adj_return_qty, 0) AS perf_adj_total_qty,
   SUM(COALESCE(SUB1.perf_adj_sales_qty, 0) + COALESCE(SUB1.perf_adj_return_qty, 0)) OVER (PARTITION BY CAST(SUB2.bus_year AS STRING)
      , CAST(SUB1.store_sid AS STRING), CAST(SUB1.prod_sid AS STRING), CAST(SUB1.sales_variant_sid AS STRING), SUB1.country_org_cd
      , SUB1.uom_cd, SUB1.curr_cd ORDER BY SUB1.bus_dt IS NULL, SUB1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS perf_adj_total_bytd_qty
  FROM ldl_data_core_dim.t_fact_retail_by_store_day_product_1 AS SUB1
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date_1 AS SUB2 ON SUB1.bus_dt = SUB2.cal_dt) AS f_tsdp_py ON D_CD.prev_1y_cal_dt
         = f_tsdp_py.bus_dt AND F_TSDP.store_sid = f_tsdp_py.store_sid AND F_TSDP.prod_sid = f_tsdp_py.prod_sid AND
      F_TSDP.sales_variant_sid = f_tsdp_py.sales_variant_sid AND F_TSDP.country_org_cd = f_tsdp_py.country_org_cd AND
    F_TSDP.uom_cd = f_tsdp_py.uom_cd AND F_TSDP.curr_cd = f_tsdp_py.curr_cd
 LEFT JOIN (SELECT SUB10.bus_dt,
   SUB10.store_sid,
   SUB10.prod_sid,
   SUB10.sales_variant_sid,
   SUB10.country_org_sid,
   SUB10.country_org_cd,
   SUB10.uom_cd,
   SUB10.curr_cd,
    COALESCE(SUB10.cash_register_sales_net_val, 0) + COALESCE(SUB10.cash_register_return_net_val, 0) AS turnover_net_val
   ,
   SUM(COALESCE(SUB10.cash_register_sales_net_val, 0) + COALESCE(SUB10.cash_register_return_net_val, 0)) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING)
      , CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING), CAST(SUB10.sales_variant_sid AS STRING), SUB10
      .country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt IS NULL, SUB10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val,
   SUB10.cash_register_sales_net_val AS sales_net_val,
   SUM(SUB10.cash_register_sales_net_val) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING)
      , CAST(SUB10.prod_sid AS STRING), CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd,
      SUB10.curr_cd ORDER BY SUB10.bus_dt IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sales_bytd_net_val,
   SUB10.cash_register_return_net_val AS return_net_val,
   SUM(SUB10.cash_register_return_net_val) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING)
      , CAST(SUB10.prod_sid AS STRING), CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd,
      SUB10.curr_cd ORDER BY SUB10.bus_dt IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_bytd_net_val,
   SUB10.sales_cnt,
   SUM(SUB10.sales_cnt) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING)
      , CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt
      IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
   SUB10.sales_qty,
   SUM(SUB10.sales_qty) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING)
      , CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt
      IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
   SUB10.return_cnt,
   SUM(SUB10.return_cnt) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING)
      , CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt
      IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
   SUB10.return_qty,
   SUM(SUB10.return_qty) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING), CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING)
      , CAST(SUB10.sales_variant_sid AS STRING), SUB10.country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt
      IS NULL, SUB10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
    COALESCE(SUB10.perf_adj_sales_cnt, 0) + COALESCE(SUB10.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
   SUM(COALESCE(SUB10.perf_adj_sales_cnt, 0) + COALESCE(SUB10.perf_adj_return_cnt, 0)) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING)
      , CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING), CAST(SUB10.sales_variant_sid AS STRING), SUB10
      .country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt IS NULL, SUB10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_cnt,
    COALESCE(SUB10.perf_adj_sales_qty, 0) + COALESCE(SUB10.perf_adj_return_qty, 0) AS perf_adj_total_qty,
   SUM(COALESCE(SUB10.perf_adj_sales_qty, 0) + COALESCE(SUB10.perf_adj_return_qty, 0)) OVER (PARTITION BY CAST(SUB20.bus_year AS STRING)
      , CAST(SUB10.store_sid AS STRING), CAST(SUB10.prod_sid AS STRING), CAST(SUB10.sales_variant_sid AS STRING), SUB10
      .country_org_cd, SUB10.uom_cd, SUB10.curr_cd ORDER BY SUB10.bus_dt IS NULL, SUB10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_qty
  FROM ldl_data_core_dim.t_fact_retail_by_store_day_product_1 AS SUB10
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date_1 AS SUB20 ON SUB10.bus_dt = SUB20.cal_dt) AS f_tsdp_py_swday ON D_CD
        .prev_1y_swday_cal_dt = f_tsdp_py_swday.bus_dt AND F_TSDP.store_sid = f_tsdp_py_swday.store_sid AND F_TSDP.prod_sid
        = f_tsdp_py_swday.prod_sid AND F_TSDP.sales_variant_sid = f_tsdp_py_swday.sales_variant_sid AND F_TSDP.country_org_cd
      = f_tsdp_py_swday.country_org_cd AND F_TSDP.uom_cd = f_tsdp_py_swday.uom_cd AND F_TSDP.curr_cd = f_tsdp_py_swday.curr_cd;