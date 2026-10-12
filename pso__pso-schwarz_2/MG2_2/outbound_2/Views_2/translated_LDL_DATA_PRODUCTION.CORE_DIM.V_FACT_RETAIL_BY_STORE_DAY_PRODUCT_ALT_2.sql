CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_retail_by_store_day_product_alt_2 (bus_dt, store_sid, prod_sid
, sales_variant_sid, country_org_sid, country_org_cd, total_cnt, total_qty, uom_cd, turnover_net_val, turnover_gross_val
, curr_cd, turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val,
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
dwh_node_cd) AS SELECT f_tsdp.bus_dt,
 f_tsdp.store_sid,
 f_tsdp.prod_sid,
 f_tsdp.sales_variant_sid,
 f_tsdp.country_org_sid,
 f_tsdp.country_org_cd,
  COALESCE(f_tsdp.sales_cnt, 0) + COALESCE(f_tsdp.return_cnt, 0) AS total_cnt,
  COALESCE(f_tsdp.sales_qty, 0) + COALESCE(f_tsdp.return_qty, 0) AS total_qty,
 f_tsdp.uom_cd,
  COALESCE(f_tsdp.cash_register_sales_net_val, 0) + COALESCE(f_tsdp.cash_register_return_net_val, 0) AS turnover_net_val
 ,
  COALESCE(f_tsdp.cash_register_sales_gross_val, 0) + COALESCE(f_tsdp.cash_register_return_gross_val, 0) AS
 turnover_gross_val,
 f_tsdp.curr_cd,
 SUM(COALESCE(f_tsdp.cash_register_sales_net_val, 0) + COALESCE(f_tsdp.cash_register_return_net_val, 0)) OVER (PARTITION BY
    d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd,
    f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 turnover_bytd_net_val,
 f_tsdp_py.turnover_net_val AS turnover_py_net_val,
 f_tsdp_py.turnover_bytd_net_val AS turnover_py_bytd_net_val,
 f_tsdp_py_swday.turnover_net_val AS turnover_py_swday_net_val,
 f_tsdp_py_swday.turnover_bytd_net_val AS turnover_py_swday_bytd_net_val,
 f_tsdp.cash_register_sales_net_val AS sales_net_val,
 SUM(f_tsdp.cash_register_sales_net_val) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid
    , f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_net_val,
 f_tsdp_py.sales_net_val AS sales_py_net_val,
 f_tsdp_py.sales_bytd_net_val AS sales_py_bytd_net_val,
 f_tsdp_py_swday.sales_net_val AS sales_py_swday_net_val,
 f_tsdp_py_swday.sales_bytd_net_val AS sales_py_swday_bytd_net_val,
 f_tsdp.cash_register_return_net_val AS return_net_val,
 SUM(f_tsdp.cash_register_return_net_val) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid
    , f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_net_val,
 f_tsdp_py.return_net_val AS return_py_net_val,
 f_tsdp_py.return_bytd_net_val AS return_py_bytd_net_val,
 f_tsdp_py_swday.return_net_val AS return_py_swday_net_val,
 f_tsdp_py_swday.return_bytd_net_val AS return_py_swday_bytd_net_val,
 f_tsdp.sales_cnt,
 SUM(f_tsdp.sales_cnt) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid,
    f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
 f_tsdp_py.sales_cnt AS sales_py_cnt,
 f_tsdp_py.sales_bytd_cnt AS sales_py_bytd_cnt,
 f_tsdp_py_swday.sales_cnt AS sales_py_swday_cnt,
 f_tsdp_py_swday.sales_bytd_cnt AS sales_py_swday_bytd_cnt,
 f_tsdp.sales_qty,
 SUM(f_tsdp.sales_qty) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid,
    f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
 f_tsdp_py.sales_qty AS sales_py_qty,
 f_tsdp_py.sales_bytd_qty AS sales_py_bytd_qty,
 f_tsdp_py_swday.sales_qty AS sales_py_swday_qty,
 f_tsdp_py_swday.sales_bytd_qty AS sales_py_swday_bytd_qty,
 f_tsdp.return_cnt,
 SUM(f_tsdp.return_cnt) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid,
    f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
 f_tsdp_py.return_cnt AS return_py_cnt,
 f_tsdp_py.return_bytd_cnt AS return_py_bytd_cnt,
 f_tsdp_py_swday.return_cnt AS return_py_swday_cnt,
 f_tsdp_py_swday.return_bytd_cnt AS return_py_swday_bytd_cnt,
 f_tsdp.return_qty,
 SUM(f_tsdp.return_qty) OVER (PARTITION BY d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid,
    f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
 f_tsdp_py.return_qty AS return_py_qty,
 f_tsdp_py.return_bytd_qty AS return_py_bytd_qty,
 f_tsdp_py_swday.return_qty AS return_py_swday_qty,
 f_tsdp_py_swday.return_bytd_qty AS return_py_swday_bytd_qty,
  COALESCE(f_tsdp.perf_adj_sales_cnt, 0) + COALESCE(f_tsdp.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
 SUM(COALESCE(f_tsdp.perf_adj_sales_cnt, 0) + COALESCE(f_tsdp.perf_adj_return_cnt, 0)) OVER (PARTITION BY d_cd.bus_year
    , f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
  ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 perf_adj_total_bytd_cnt,
 f_tsdp_py.perf_adj_total_cnt AS perf_adj_total_py_cnt,
 f_tsdp_py.perf_adj_total_bytd_cnt AS perf_adj_total_py_bytd_cnt,
 f_tsdp_py_swday.perf_adj_total_cnt AS perf_adj_total_py_swday_cnt,
 f_tsdp_py_swday.perf_adj_total_bytd_cnt AS perf_adj_total_py_swday_bytd_cnt,
  COALESCE(f_tsdp.perf_adj_sales_qty, 0) + COALESCE(f_tsdp.perf_adj_return_qty, 0) AS perf_adj_total_qty,
 SUM(COALESCE(f_tsdp.perf_adj_sales_qty, 0) + COALESCE(f_tsdp.perf_adj_return_qty, 0)) OVER (PARTITION BY d_cd.bus_year
    , f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
  ORDER BY f_tsdp.bus_dt IS NULL, f_tsdp.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 perf_adj_total_bytd_qty,
 f_tsdp_py.perf_adj_total_qty AS perf_adj_total_py_qty,
 f_tsdp_py.perf_adj_total_bytd_qty AS perf_adj_total_py_bytd_qty,
 f_tsdp_py_swday.perf_adj_total_qty AS perf_adj_total_py_swday_qty,
 f_tsdp_py_swday.perf_adj_total_bytd_qty AS perf_adj_total_py_swday_bytd_qty,
 f_tsdp.dwh_created_tmsp,
 f_tsdp.dwh_updated_tmsp,
 f_tsdp.dwh_load_id,
 f_tsdp.dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product_2 AS f_tsdp
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS d_cd ON f_tsdp.bus_dt = d_cd.cal_dt
 LEFT JOIN (SELECT sub1.bus_dt,
   sub1.store_sid,
   sub1.prod_sid,
   sub1.sales_variant_sid,
   sub1.country_org_sid,
   sub1.country_org_cd,
   sub1.uom_cd,
   sub1.curr_cd,
    COALESCE(sub1.cash_register_sales_net_val, 0) + COALESCE(sub1.cash_register_return_net_val, 0) AS turnover_net_val,
   SUM(COALESCE(sub1.cash_register_sales_net_val, 0) + COALESCE(sub1.cash_register_return_net_val, 0)) OVER (PARTITION BY
      sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
      ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_bytd_net_val,
   sub1.cash_register_sales_net_val AS sales_net_val,
   SUM(sub1.cash_register_sales_net_val) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid
      , sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_net_val,
   sub1.cash_register_return_net_val AS return_net_val,
   SUM(sub1.cash_register_return_net_val) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid
      , sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_net_val,
   sub1.sales_cnt,
   SUM(sub1.sales_cnt) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd
      , sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS sales_bytd_cnt,
   sub1.sales_qty,
   SUM(sub1.sales_qty) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd
      , sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS sales_bytd_qty,
   sub1.return_cnt,
   SUM(sub1.return_cnt) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd
      , sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS return_bytd_cnt,
   sub1.return_qty,
   SUM(sub1.return_qty) OVER (PARTITION BY sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd
      , sub1.uom_cd, sub1.curr_cd ORDER BY sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS return_bytd_qty,
    COALESCE(sub1.perf_adj_sales_cnt, 0) + COALESCE(sub1.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
   SUM(COALESCE(sub1.perf_adj_sales_cnt, 0) + COALESCE(sub1.perf_adj_return_cnt, 0)) OVER (PARTITION BY sub2.bus_year,
      sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd ORDER BY
      sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_cnt,
    COALESCE(sub1.perf_adj_sales_qty, 0) + COALESCE(sub1.perf_adj_return_qty, 0) AS perf_adj_total_qty,
   SUM(COALESCE(sub1.perf_adj_sales_qty, 0) + COALESCE(sub1.perf_adj_return_qty, 0)) OVER (PARTITION BY sub2.bus_year,
      sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd ORDER BY
      sub1.bus_dt IS NULL, sub1.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_total_bytd_qty
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product_2 AS sub1
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS sub2 ON sub1.bus_dt = sub2.cal_dt) AS f_tsdp_py ON
        d_cd.prev_1y_cal_dt = f_tsdp_py.bus_dt AND f_tsdp.store_sid = f_tsdp_py.store_sid AND f_tsdp.prod_sid =
       f_tsdp_py.prod_sid AND f_tsdp.sales_variant_sid = f_tsdp_py.sales_variant_sid AND f_tsdp.country_org_cd =
     f_tsdp_py.country_org_cd AND f_tsdp.uom_cd = f_tsdp_py.uom_cd AND f_tsdp.curr_cd = f_tsdp_py.curr_cd
 LEFT JOIN (SELECT sub10.bus_dt,
   sub10.store_sid,
   sub10.prod_sid,
   sub10.sales_variant_sid,
   sub10.country_org_sid,
   sub10.country_org_cd,
   sub10.uom_cd,
   sub10.curr_cd,
    COALESCE(sub10.cash_register_sales_net_val, 0) + COALESCE(sub10.cash_register_return_net_val, 0) AS turnover_net_val
   ,
   SUM(COALESCE(sub10.cash_register_sales_net_val, 0) + COALESCE(sub10.cash_register_return_net_val, 0)) OVER (PARTITION BY
      sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid, sub10.country_org_cd, sub10.uom_cd,
      sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_bytd_net_val,
   sub10.cash_register_sales_net_val AS sales_net_val,
   SUM(sub10.cash_register_sales_net_val) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid
      , sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_net_val,
   sub10.cash_register_return_net_val AS return_net_val,
   SUM(sub10.cash_register_return_net_val) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid
      , sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_net_val,
   sub10.sales_cnt,
   SUM(sub10.sales_cnt) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid,
      sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
   sub10.sales_qty,
   SUM(sub10.sales_qty) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid,
      sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
   sub10.return_cnt,
   SUM(sub10.return_cnt) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid,
      sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
   sub10.return_qty,
   SUM(sub10.return_qty) OVER (PARTITION BY sub20.bus_year, sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid,
      sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
    COALESCE(sub10.perf_adj_sales_cnt, 0) + COALESCE(sub10.perf_adj_return_cnt, 0) AS perf_adj_total_cnt,
   SUM(COALESCE(sub10.perf_adj_sales_cnt, 0) + COALESCE(sub10.perf_adj_return_cnt, 0)) OVER (PARTITION BY sub20.bus_year
      , sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid, sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd
    ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_total_bytd_cnt,
    COALESCE(sub10.perf_adj_sales_qty, 0) + COALESCE(sub10.perf_adj_return_qty, 0) AS perf_adj_total_qty,
   SUM(COALESCE(sub10.perf_adj_sales_qty, 0) + COALESCE(sub10.perf_adj_return_qty, 0)) OVER (PARTITION BY sub20.bus_year
      , sub10.store_sid, sub10.prod_sid, sub10.sales_variant_sid, sub10.country_org_cd, sub10.uom_cd, sub10.curr_cd
    ORDER BY sub10.bus_dt IS NULL, sub10.bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_total_bytd_qty
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product_2 AS sub10
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS sub20 ON sub10.bus_dt = sub20.cal_dt) AS
 f_tsdp_py_swday ON d_cd.prev_1y_swday_cal_dt = f_tsdp_py_swday.bus_dt AND f_tsdp.store_sid = f_tsdp_py_swday.store_sid
      AND f_tsdp.prod_sid = f_tsdp_py_swday.prod_sid AND f_tsdp.sales_variant_sid = f_tsdp_py_swday.sales_variant_sid
    AND f_tsdp.country_org_cd = f_tsdp_py_swday.country_org_cd AND f_tsdp.uom_cd = f_tsdp_py_swday.uom_cd AND f_tsdp.curr_cd
    = f_tsdp_py_swday.curr_cd;