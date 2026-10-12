-- !SET exit_on_error=True;

-- PERF_ADJ_SALES_CNT
-- PERF_ADJ_SALES_QTY
-- PERF_ADJ_RETURN_CNT
-- PERF_ADJ_RETURN_QTY
-- TURNOVER_NET_VAL
BEGIN TRANSACTION;


TRUNCATE TABLE ldl_data_production_core_dim.t_fact_retail_growth_by_store_day_1;


INSERT INTO ldl_data_production_core_dim.t_fact_retail_growth_by_store_day_1 (bus_dt, int_org_sid, int_org_type_cd,
 country_org_cd, perf_adj_sales_cnt, perf_adj_sales_bytd_cnt, perf_adj_sales_py_cnt, perf_adj_sales_py_bytd_cnt,
 perf_adj_sales_py_swday_cnt, perf_adj_sales_py_swday_bytd_cnt, perf_adj_sales_qty, perf_adj_sales_bytd_qty,
 perf_adj_sales_py_qty, perf_adj_sales_py_bytd_qty, perf_adj_sales_py_swday_qty, perf_adj_sales_py_swday_bytd_qty,
 perf_adj_return_cnt, perf_adj_return_bytd_cnt, perf_adj_return_py_cnt, perf_adj_return_py_bytd_cnt,
 perf_adj_return_py_swday_cnt, perf_adj_return_py_swday_bytd_cnt, perf_adj_return_qty, perf_adj_return_bytd_qty,
 perf_adj_return_py_qty, perf_adj_return_py_bytd_qty, perf_adj_return_py_swday_qty, perf_adj_return_py_swday_bytd_qty,
 uom_cd, turnover_net_val, turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val,
 turnover_py_swday_net_val, turnover_py_swday_bytd_net_val, curr_cd, receipt_cnt, receipt_bytd_cnt, receipt_py_cnt,
 receipt_py_bytd_cnt, receipt_py_swday_cnt, receipt_py_swday_bytd_cnt, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id,
 dwh_node_cd)
(SELECT t0.bus_dt,
  t0.int_org_sid,
  t0.int_org_type_cd,
  t0.country_org_cd,
  t0.perf_adj_sales_cnt,
  t0.perf_adj_sales_bytd_cnt,
  CAST(t0.perf_adj_sales_py_cnt AS INTEGER) AS perf_adj_sales_py_cnt,
  t0.perf_adj_sales_py_bytd_cnt,
  t0.perf_adj_sales_py_swday_cnt,
  t0.perf_adj_sales_py_swday_bytd_cnt,
  CAST(t0.perf_adj_sales_qty AS NUMERIC) AS perf_adj_sales_qty,
  CAST(t0.perf_adj_sales_bytd_qty AS NUMERIC) AS perf_adj_sales_bytd_qty,
  CAST(t0.perf_adj_sales_py_qty AS NUMERIC) AS perf_adj_sales_py_qty,
  CAST(t0.perf_adj_sales_py_bytd_qty AS NUMERIC) AS perf_adj_sales_py_bytd_qty,
  CAST(t0.perf_adj_sales_py_swday_qty AS NUMERIC) AS perf_adj_sales_py_swday_qty,
  CAST(t0.perf_adj_sales_py_swday_bytd_qty AS NUMERIC) AS perf_adj_sales_py_swday_bytd_qty,
  t0.perf_adj_return_cnt,
  t0.perf_adj_return_bytd_cnt,
  t0.perf_adj_return_py_cnt,
  t0.perf_adj_return_py_bytd_cnt,
  t0.perf_adj_return_py_swday_cnt,
  t0.perf_adj_return_py_swday_bytd_cnt,
  CAST(t0.perf_adj_return_qty AS NUMERIC) AS perf_adj_return_qty,
  CAST(t0.perf_adj_return_bytd_qty AS NUMERIC) AS perf_adj_return_bytd_qty,
  CAST(t0.perf_adj_return_py_qty AS NUMERIC) AS perf_adj_return_py_qty,
  CAST(t0.perf_adj_return_py_bytd_qty AS NUMERIC) AS perf_adj_return_py_bytd_qty,
  CAST(t0.A26 AS NUMERIC) AS A26,
  CAST(t0.perf_adj_return_py_swday_bytd_qty AS NUMERIC) AS perf_adj_return_py_swday_bytd_qty,
  t0.uom_cd,
  CAST(t0.turnover_net_val AS NUMERIC) AS turnover_net_val,
  CAST(t0.turnover_bytd_net_val AS NUMERIC) AS turnover_bytd_net_val,
  CAST(t0.A31 AS NUMERIC) AS A31,
  CAST(t0.turnover_py_bytd_net_val AS NUMERIC) AS turnover_py_bytd_net_val,
  CAST(t0.A33 AS NUMERIC) AS A33,
  CAST(t0.turnover_py_swday_bytd_net_val AS NUMERIC) AS turnover_py_swday_bytd_net_val,
  t0.curr_cd,
  t0.receipt_cnt,
  t0.receipt_bytd_cnt,
  t0.A38,
  t0.receipt_py_bytd_cnt,
  t0.A40,
  t0.receipt_py_swday_bytd_cnt,
  t0.dwh_created_tmsp,
  t0.dwh_updated_tmsp,
  t0.dwh_load_id,
  t0.dwh_node_cd
 FROM (SELECT tf.bus_dt,
    tf.int_org_sid,
    tf.int_org_type_cd,
    tf.country_org_cd,
     tf.perf_adj_sales_cnt * CASE
      WHEN tfs.relevant_for_comp_fg
      THEN 1
      ELSE 0
      END AS perf_adj_sales_cnt,
    SUM(tf.perf_adj_sales_cnt * CASE
       WHEN tfs.relevant_for_comp_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_bytd_cnt,
     tf.perf_adj_sales_py_cnt * CASE
      WHEN tfs.relevant_for_comp_py_fg IS NOT NULL
      THEN CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END
      ELSE NULL
      END AS perf_adj_sales_py_cnt,
    SUM(tf.perf_adj_sales_py_cnt * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_py_bytd_cnt,
     tf.perf_adj_sales_py_swday_cnt * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS perf_adj_sales_py_swday_cnt,
    SUM(tf.perf_adj_sales_py_swday_cnt * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_py_swday_bytd_cnt,
     tf.perf_adj_sales_qty * CASE
      WHEN tfs.relevant_for_comp_fg
      THEN 1
      ELSE 0
      END AS perf_adj_sales_qty,
    SUM(tf.perf_adj_sales_qty * CASE
       WHEN tfs.relevant_for_comp_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_bytd_qty,
     tf.perf_adj_sales_py_qty * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS perf_adj_sales_py_qty,
    SUM(tf.perf_adj_sales_py_qty * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_py_bytd_qty,
     tf.perf_adj_sales_py_swday_qty * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS perf_adj_sales_py_swday_qty,
    SUM(tf.perf_adj_sales_py_swday_qty * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_sales_py_swday_bytd_qty,
     tf.perf_adj_return_cnt * CASE
      WHEN tfs.relevant_for_comp_fg
      THEN 1
      ELSE 0
      END AS perf_adj_return_cnt,
    SUM(tf.perf_adj_return_cnt * CASE
       WHEN tfs.relevant_for_comp_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_bytd_cnt,
     tf.perf_adj_return_py_cnt * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS perf_adj_return_py_cnt,
    SUM(tf.perf_adj_return_py_cnt * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_py_bytd_cnt,
     tf.perf_adj_return_py_swday_cnt * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS perf_adj_return_py_swday_cnt,
    SUM(tf.perf_adj_return_py_swday_cnt * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_py_swday_bytd_cnt,
     tf.perf_adj_return_qty * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS perf_adj_return_qty,
    SUM(tf.perf_adj_return_qty * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_bytd_qty,
     tf.perf_adj_return_py_qty * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS perf_adj_return_py_qty,
    SUM(tf.perf_adj_return_py_qty * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_py_bytd_qty,
     tf.perf_adj_return_py_swday_qty * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS A26,
    SUM(tf.perf_adj_return_py_swday_qty * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS perf_adj_return_py_swday_bytd_qty,
    COALESCE(tf.uom_cd, '@') AS uom_cd,
     tf.turnover_net_val * CASE
      WHEN tfs.relevant_for_comp_fg
      THEN 1
      ELSE 0
      END AS turnover_net_val,
    SUM(tf.turnover_net_val * CASE
       WHEN tfs.relevant_for_comp_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val,
     tf.turnover_py_net_val * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS A31,
    SUM(tf.turnover_py_net_val * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_py_bytd_net_val,
     tf.turnover_py_swday_net_val * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS A33,
    SUM(tf.turnover_py_swday_net_val * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_py_swday_bytd_net_val,
    tf.curr_cd,
     tf.receipt_cnt * CASE
      WHEN tfs.relevant_for_comp_fg
      THEN 1
      ELSE 0
      END AS receipt_cnt,
    SUM(tf.receipt_cnt * CASE
       WHEN tfs.relevant_for_comp_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_bytd_cnt,
     tf.receipt_py_cnt * CASE
      WHEN tfs.relevant_for_comp_py_fg
      THEN 1
      ELSE 0
      END AS A38,
    SUM(tf.receipt_py_cnt * CASE
       WHEN tfs.relevant_for_comp_py_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_bytd_cnt,
     tf.receipt_py_swday_cnt * CASE
      WHEN tfs.relevant_for_comp_py_swday_fg
      THEN 1
      ELSE 0
      END AS A40,
    SUM(tf.receipt_py_swday_cnt * CASE
       WHEN tfs.relevant_for_comp_py_swday_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY tf.int_org_sid, cal.bus_year ORDER BY tf.bus_dt IS NULL, tf.bus_dt ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_swday_bytd_cnt,
    tf.dwh_created_tmsp,
    tf.dwh_updated_tmsp,
    tf.dwh_load_id,
    tf.dwh_node_cd
   FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_1 AS tf
    INNER JOIN ldl_data_production_core_dim.t_fact_store_open_days_1 AS tfs ON tf.int_org_sid = tfs.store_sid AND tf.bus_dt
       = tfs.bus_dt
    INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_1 AS cal ON tf.bus_dt BETWEEN cal.cal_month_begin_dt AND
     cal.cal_month_end_dt
   ORDER BY tf.country_org_cd NULLS LAST,
    tf.bus_dt NULLS LAST) AS t0);


COMMIT TRANSACTION;