CREATE OR REPLACE VIEW ldl_data_etl.v_fact_retail_by_store_day AS WITH PY AS (SELECT DR.cal_dt,
   SRC0.int_org_sid,
   SUM(SRC0.turnover_net_val) AS turnover_py_net_val,
   SUM(SRC0.turnover_gross_val) AS turnover_py_gross_val,
   SUM(SRC0.receipt_cnt) AS receipt_py_cnt,
   SUM(SRC0.plan_turnover_net_val) AS plan_turnover_py_net_val,
   SUM(SRC0.plan_receipt_cnt) AS plan_receipt_py_cnt,
   SUM(SRC0.sales_cnt) AS sales_py_cnt,
   SUM(SRC0.return_cnt) AS return_py_cnt,
   SUM(SRC0.sales_qty) AS sales_py_qty,
   SUM(SRC0.return_qty) AS return_py_qty,
   SUM(SRC0.perf_adj_return_cnt) AS perf_adj_return_py_cnt,
   SUM(SRC0.perf_adj_sales_cnt) AS perf_adj_sales_py_cnt,
   SUM(SRC0.perf_adj_sales_qty) AS perf_adj_sales_py_qty,
   SUM(SRC0.perf_adj_return_qty) AS perf_adj_return_py_qty,
   SUM(SRC0.perf_adj_sales_net_val) AS perf_adj_sales_py_net_val,
   SUM(SRC0.perf_adj_return_net_val) AS perf_adj_return_py_net_val,
   SUM(SRC0.cash_register_sales_net_val) AS cash_register_sales_py_net_val,
   SUM(SRC0.cash_register_return_net_val) AS cash_register_return_py_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC0
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR ON SRC0.bus_dt = DR.rel_cal_dt AND DR.cal_dt_adjust_type_cd
       = 'M' AND DR.bus_year_diff = 1
  GROUP BY SRC0.int_org_sid,
   DR.cal_dt), PYBD AS (SELECT DR0.cal_dt,
   SRC1.int_org_sid,
   SUM(SRC1.turnover_net_val) AS turnover_py_bytd_net_val,
   SUM(SRC1.turnover_gross_val) AS turnover_py_bytd_gross_val,
   SUM(SRC1.receipt_cnt) AS receipt_py_bytd_cnt,
   SUM(SRC1.plan_turnover_net_val) AS plan_turnover_py_bytd_net_val,
   SUM(SRC1.plan_receipt_cnt) AS plan_receipt_py_bytd_cnt,
   SUM(SRC1.sales_cnt) AS sales_py_bytd_cnt,
   SUM(SRC1.return_cnt) AS return_py_bytd_cnt,
   SUM(SRC1.sales_qty) AS sales_py_bytd_qty,
   SUM(SRC1.return_qty) AS return_py_bytd_qty,
   SUM(SRC1.perf_adj_return_cnt) AS perf_adj_return_py_bytd_cnt,
   SUM(SRC1.perf_adj_sales_cnt) AS perf_adj_sales_py_bytd_cnt,
   SUM(SRC1.perf_adj_sales_qty) AS perf_adj_sales_py_bytd_qty,
   SUM(SRC1.perf_adj_return_qty) AS perf_adj_return_py_bytd_qty,
   SUM(SRC1.perf_adj_sales_net_val) AS perf_adj_sales_py_bytd_net_val,
   SUM(SRC1.perf_adj_return_net_val) AS perf_adj_return_py_bytd_net_val,
   SUM(SRC1.cash_register_sales_net_val) AS cash_register_sales_py_bytd_net_val,
   SUM(SRC1.cash_register_return_net_val) AS cash_register_return_py_bytd_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC1
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR0 ON SRC1.bus_dt = DR0.rel_cal_dt AND DR0.cal_dt_adjust_type_cd
       = 'MC' AND DR0.bus_year_diff = 1
  GROUP BY SRC1.int_org_sid,
   DR0.cal_dt), PYSW AS (SELECT DR1.cal_dt,
   SRC2.int_org_sid,
   SUM(SRC2.turnover_net_val) AS turnover_py_swday_net_val,
   SUM(SRC2.turnover_gross_val) AS turnover_py_swday_gross_val,
   SUM(SRC2.receipt_cnt) AS receipt_py_swday_cnt,
   SUM(SRC2.plan_turnover_net_val) AS plan_turnover_py_swday_net_val,
   SUM(SRC2.plan_receipt_cnt) AS plan_receipt_py_swday_cnt,
   SUM(SRC2.sales_cnt) AS sales_py_swday_cnt,
   SUM(SRC2.return_cnt) AS return_py_swday_cnt,
   SUM(SRC2.sales_qty) AS sales_py_swday_qty,
   SUM(SRC2.return_qty) AS return_py_swday_qty,
   SUM(SRC2.perf_adj_return_cnt) AS perf_adj_return_swday_cnt,
   SUM(SRC2.perf_adj_sales_cnt) AS perf_adj_sales_swday_cnt,
   SUM(SRC2.perf_adj_sales_qty) AS perf_adj_sales_swday_qty,
   SUM(SRC2.perf_adj_return_qty) AS perf_adj_return_swday_qty,
   SUM(SRC2.perf_adj_sales_net_val) AS perf_adj_sales_swday_net_val,
   SUM(SRC2.perf_adj_return_net_val) AS perf_adj_return_swday_net_val,
   SUM(SRC2.cash_register_sales_net_val) AS cash_register_sales_py_swday_net_val,
   SUM(SRC2.cash_register_return_net_val) AS cash_register_return_py_swday_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC2
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR1 ON SRC2.bus_dt = DR1.rel_cal_dt AND DR1.cal_dt_adjust_type_cd
       = 'W' AND DR1.bus_year_diff = 1
  GROUP BY SRC2.int_org_sid,
   DR1.cal_dt), PYSWBD AS (SELECT DR2.cal_dt,
   SRC3.int_org_sid,
   SUM(SRC3.turnover_net_val) AS turnover_py_swday_bytd_net_val,
   SUM(SRC3.turnover_gross_val) AS turnover_py_swday_bytd_gross_val,
   SUM(SRC3.receipt_cnt) AS receipt_py_swday_bytd_cnt,
   SUM(SRC3.plan_turnover_net_val) AS plan_turnover_py_swday_bytd_net_val,
   SUM(SRC3.plan_receipt_cnt) AS plan_receipt_py_swday_bytd_cnt,
   SUM(SRC3.sales_cnt) AS sales_py_swday_bytd_cnt,
   SUM(SRC3.return_cnt) AS return_py_swday_bytd_cnt,
   SUM(SRC3.sales_qty) AS sales_py_swday_bytd_qty,
   SUM(SRC3.return_qty) AS return_py_swday_bytd_qty,
   SUM(SRC3.perf_adj_return_cnt) AS perf_adj_return_py_swday_bytd_cnt,
   SUM(SRC3.perf_adj_sales_cnt) AS perf_adj_sales_py_swday_bytd_cnt,
   SUM(SRC3.perf_adj_sales_qty) AS perf_adj_sales_py_swday_bytd_qty,
   SUM(SRC3.perf_adj_return_qty) AS perf_adj_return_py_swday_bytd_qty,
   SUM(SRC3.perf_adj_sales_net_val) AS perf_adj_sales_py_swday_bytd_net_val,
   SUM(SRC3.perf_adj_return_net_val) AS perf_adj_return_py_swday_bytd_net_val,
   SUM(SRC3.cash_register_sales_net_val) AS cash_register_sales_py_swday_bytd_net_val,
   SUM(SRC3.cash_register_return_net_val) AS cash_register_return_py_swday_bytd_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC3
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR2 ON SRC3.bus_dt = DR2.rel_cal_dt AND DR2.cal_dt_adjust_type_cd
       = 'WC' AND DR2.bus_year_diff = 1
  GROUP BY SRC3.int_org_sid,
   DR2.cal_dt), PPY AS (SELECT DR3.cal_dt,
   SRC4.int_org_sid,
   SUM(SRC4.turnover_net_val) AS turnover_ppy_net_val,
   SUM(SRC4.turnover_gross_val) AS turnover_ppy_gross_val,
   SUM(SRC4.receipt_cnt) AS receipt_ppy_cnt,
   SUM(SRC4.plan_turnover_net_val) AS plan_turnover_ppy_net_val,
   SUM(SRC4.plan_receipt_cnt) AS plan_receipt_ppy_cnt,
   SUM(SRC4.sales_cnt) AS sales_ppy_cnt,
   SUM(SRC4.return_cnt) AS return_ppy_cnt,
   SUM(SRC4.sales_qty) AS sales_ppy_qty,
   SUM(SRC4.return_qty) AS return_ppy_qty,
   SUM(SRC4.perf_adj_return_cnt) AS perf_adj_return_ppy_cnt,
   SUM(SRC4.perf_adj_sales_cnt) AS perf_adj_sales_ppy_cnt,
   SUM(SRC4.perf_adj_sales_qty) AS perf_adj_sales_ppy_qty,
   SUM(SRC4.perf_adj_return_qty) AS perf_adj_return_ppy_qty,
   SUM(SRC4.perf_adj_sales_net_val) AS perf_adj_sales_ppy_net_val,
   SUM(SRC4.perf_adj_return_net_val) AS perf_adj_return_ppy_net_val,
   SUM(SRC4.cash_register_sales_net_val) AS cash_register_sales_ppy_net_val,
   SUM(SRC4.cash_register_return_net_val) AS cash_register_return_ppy_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC4
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR3 ON SRC4.bus_dt = DR3.rel_cal_dt AND DR3.cal_dt_adjust_type_cd
       = 'M' AND DR3.bus_year_diff = 2
  GROUP BY SRC4.int_org_sid,
   DR3.cal_dt), PPYBD AS (SELECT DR4.cal_dt,
   SRC5.int_org_sid,
   SUM(SRC5.turnover_net_val) AS turnover_ppy_bytd_net_val,
   SUM(SRC5.turnover_gross_val) AS turnover_ppy_bytd_gross_val,
   SUM(SRC5.receipt_cnt) AS receipt_ppy_bytd_cnt,
   SUM(SRC5.plan_turnover_net_val) AS plan_turnover_ppy_bytd_net_val,
   SUM(SRC5.plan_receipt_cnt) AS plan_receipt_ppy_bytd_cnt,
   SUM(SRC5.sales_cnt) AS sales_ppy_bytd_cnt,
   SUM(SRC5.return_cnt) AS return_ppy_bytd_cnt,
   SUM(SRC5.sales_qty) AS sales_ppy_bytd_qty,
   SUM(SRC5.return_qty) AS return_ppy_bytd_qty,
   SUM(SRC5.perf_adj_return_cnt) AS perf_adj_return_ppy_bytd_cnt,
   SUM(SRC5.perf_adj_sales_cnt) AS perf_adj_sales_ppy_bytd_cnt,
   SUM(SRC5.perf_adj_sales_qty) AS perf_adj_sales_ppy_bytd_qty,
   SUM(SRC5.perf_adj_return_qty) AS perf_adj_return_ppy_bytd_qty,
   SUM(SRC5.perf_adj_sales_net_val) AS perf_adj_sales_ppy_bytd_net_val,
   SUM(SRC5.perf_adj_return_net_val) AS perf_adj_return_ppy_bytd_net_val,
   SUM(SRC5.cash_register_sales_net_val) AS cash_register_sales_ppy_bytd_net_val,
   SUM(SRC5.cash_register_return_net_val) AS cash_register_return_ppy_bytd_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC5
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR4 ON SRC5.bus_dt = DR4.rel_cal_dt AND DR4.cal_dt_adjust_type_cd
       = 'MC' AND DR4.bus_year_diff = 2
  GROUP BY SRC5.int_org_sid,
   DR4.cal_dt), PPYSW AS (SELECT DR5.cal_dt,
   SRC6.int_org_sid,
   SUM(SRC6.turnover_net_val) AS turnover_ppy_swday_net_val,
   SUM(SRC6.turnover_gross_val) AS turnover_ppy_swday_gross_val,
   SUM(SRC6.receipt_cnt) AS receipt_ppy_swday_cnt,
   SUM(SRC6.plan_turnover_net_val) AS plan_turnover_ppy_swday_net_val,
   SUM(SRC6.plan_receipt_cnt) AS plan_receipt_ppy_swday_cnt,
   SUM(SRC6.sales_cnt) AS sales_ppy_swday_cnt,
   SUM(SRC6.return_cnt) AS return_ppy_swday_cnt,
   SUM(SRC6.sales_qty) AS sales_ppy_swday_qty,
   SUM(SRC6.return_qty) AS return_ppy_swday_qty,
   SUM(SRC6.perf_adj_return_cnt) AS perf_adj_return_ppy_swday_cnt,
   SUM(SRC6.perf_adj_sales_cnt) AS perf_adj_sales_ppy_swday_cnt,
   SUM(SRC6.perf_adj_sales_qty) AS perf_adj_sales_ppy_swday_qty,
   SUM(SRC6.perf_adj_return_qty) AS perf_adj_return_ppy_swday_qty,
   SUM(SRC6.perf_adj_sales_net_val) AS perf_adj_sales_ppy_swday_net_val,
   SUM(SRC6.perf_adj_return_net_val) AS perf_adj_return_ppy_swday_net_val,
   SUM(SRC6.cash_register_sales_net_val) AS cash_register_sales_ppy_swday_net_val,
   SUM(SRC6.cash_register_return_net_val) AS cash_register_return_ppy_swday_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC6
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR5 ON SRC6.bus_dt = DR5.rel_cal_dt AND DR5.cal_dt_adjust_type_cd
       = 'W' AND DR5.bus_year_diff = 2
  GROUP BY SRC6.int_org_sid,
   DR5.cal_dt), PPYSWBD AS (SELECT DR6.cal_dt,
   SRC7.int_org_sid,
   SUM(SRC7.turnover_net_val) AS turnover_ppy_swday_bytd_net_val,
   SUM(SRC7.turnover_gross_val) AS turnover_ppy_swday_bytd_gross_val,
   SUM(SRC7.receipt_cnt) AS receipt_ppy_swday_bytd_cnt,
   SUM(SRC7.plan_turnover_net_val) AS plan_turnover_ppy_swday_bytd_net_val,
   SUM(SRC7.plan_receipt_cnt) AS plan_receipt_ppy_swday_bytd_cnt,
   SUM(SRC7.sales_cnt) AS sales_ppy_swday_bytd_cnt,
   SUM(SRC7.return_cnt) AS return_ppy_swday_bytd_cnt,
   SUM(SRC7.sales_qty) AS sales_ppy_swday_bytd_qty,
   SUM(SRC7.return_qty) AS return_ppy_swday_bytd_qty,
   SUM(SRC7.perf_adj_return_cnt) AS perf_adj_return_ppy_swday_bytd_cnt,
   SUM(SRC7.perf_adj_sales_cnt) AS perf_adj_sales_ppy_swday_bytd_cnt,
   SUM(SRC7.perf_adj_sales_qty) AS perf_adj_sales_ppy_swday_bytd_qty,
   SUM(SRC7.perf_adj_return_qty) AS perf_adj_return_ppy_swday_bytd_qty,
   SUM(SRC7.perf_adj_sales_net_val) AS perf_adj_sales_ppy_swday_bytd_net_val,
   SUM(SRC7.perf_adj_return_net_val) AS perf_adj_return_ppy_swday_bytd_net_val,
   SUM(SRC7.cash_register_sales_net_val) AS cash_register_sales_ppy_swday_bytd_net_val,
   SUM(SRC7.cash_register_return_net_val) AS cash_register_return_ppy_swday_bytd_net_val
  FROM ldl_data_etl.t_tcache_fact_retail_by_store_day AS SRC7
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship AS DR6 ON SRC7.bus_dt = DR6.rel_cal_dt AND DR6.cal_dt_adjust_type_cd
       = 'WC' AND DR6.bus_year_diff = 2
  GROUP BY SRC7.int_org_sid,
   DR6.cal_dt) (SELECT SRC.cal_dt AS bus_dt,
   SRC.int_org_sid,
   SRC.int_org_type_cd,
   SRC.country_org_cd,
   FSRC.sales_cnt,
   SUM(FSRC.sales_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY SRC.cal_dt
      IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
   t2.sales_py_cnt,
   SUM(t6.sales_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_bytd_cnt,
   t10.sales_py_swday_cnt,
   SUM(t14.sales_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_swday_bytd_cnt
   ,
   t18.sales_ppy_cnt,
   SUM(t22.sales_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_ppy_bytd_cnt,
   t26.sales_ppy_swday_cnt,
   SUM(t30.sales_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sales_ppy_swday_bytd_cnt,
   FSRC.sales_qty,
   SUM(FSRC.sales_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY SRC.cal_dt
      IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
   t2.sales_py_qty,
   SUM(t6.sales_py_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_bytd_qty,
   t10.sales_py_swday_qty,
   SUM(t14.sales_py_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_swday_bytd_qty
   ,
   t18.sales_ppy_qty,
   SUM(t22.sales_ppy_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_ppy_bytd_qty,
   t26.sales_ppy_swday_qty,
   SUM(t30.sales_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sales_ppy_swday_bytd_qty,
   FSRC.return_cnt,
   SUM(COALESCE(FSRC.return_cnt, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
   t2.return_py_cnt,
   SUM(t6.return_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_py_bytd_cnt,
   t10.return_py_swday_cnt,
   SUM(t14.return_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_py_swday_bytd_cnt,
   t18.return_ppy_cnt,
   SUM(t22.return_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_ppy_bytd_cnt,
   t26.return_ppy_swday_cnt,
   SUM(t30.return_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_ppy_swday_bytd_cnt,
   FSRC.return_qty,
   SUM(COALESCE(FSRC.return_qty, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
   t2.return_py_qty,
   SUM(t6.return_py_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_py_bytd_qty,
   t10.return_py_swday_qty,
   SUM(t14.return_py_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_py_swday_bytd_qty,
   t18.return_ppy_qty,
   SUM(t22.return_ppy_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_ppy_bytd_qty,
   t26.return_ppy_swday_qty,
   SUM(t30.return_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_ppy_swday_bytd_qty,
   FSRC.perf_adj_sales_cnt,
   SUM(COALESCE(FSRC.perf_adj_sales_cnt, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_cnt,
   t2.perf_adj_sales_py_cnt,
   SUM(t6.perf_adj_sales_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_cnt,
   t10.perf_adj_sales_swday_cnt,
   SUM(t14.perf_adj_sales_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_cnt,
   t18.perf_adj_sales_ppy_cnt,
   SUM(t22.perf_adj_sales_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_cnt,
   t26.perf_adj_sales_ppy_swday_cnt,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_cnt,
   FSRC.perf_adj_sales_qty,
   SUM(COALESCE(FSRC.perf_adj_sales_qty, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_qty,
   t2.perf_adj_sales_py_qty,
   SUM(t6.perf_adj_sales_py_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_qty,
   t10.perf_adj_sales_swday_qty,
   SUM(t14.perf_adj_sales_py_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_qty,
   t18.perf_adj_sales_ppy_qty,
   SUM(t22.perf_adj_sales_ppy_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_qty,
   t26.perf_adj_sales_ppy_swday_qty,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_qty,
   FSRC.perf_adj_return_cnt,
   SUM(COALESCE(FSRC.perf_adj_return_cnt, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_cnt,
   t2.perf_adj_return_py_cnt,
   SUM(t6.perf_adj_return_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_cnt,
   t10.perf_adj_return_swday_cnt,
   SUM(t14.perf_adj_return_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_cnt,
   t18.perf_adj_return_ppy_cnt,
   SUM(t22.perf_adj_return_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_cnt,
   t26.perf_adj_return_ppy_swday_cnt,
   SUM(t30.perf_adj_return_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_cnt,
   FSRC.perf_adj_return_qty,
   SUM(COALESCE(FSRC.perf_adj_return_qty, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_qty,
   t2.perf_adj_return_py_qty,
   SUM(t6.perf_adj_return_py_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_qty,
   t10.perf_adj_return_swday_qty,
   SUM(t14.perf_adj_return_py_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_qty,
   t18.perf_adj_return_ppy_qty,
   SUM(t22.perf_adj_return_ppy_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_qty,
   t26.perf_adj_return_ppy_swday_qty,
   SUM(t30.perf_adj_return_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_qty,
   FSRC.perf_adj_sales_net_val,
   SUM(COALESCE(FSRC.perf_adj_sales_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_net_val,
   t2.perf_adj_sales_py_net_val,
   SUM(t6.perf_adj_sales_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_net_val,
   t10.perf_adj_sales_swday_net_val,
   SUM(t14.perf_adj_sales_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_net_val,
   t18.perf_adj_sales_ppy_net_val,
   SUM(t22.perf_adj_sales_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_net_val,
   t26.perf_adj_sales_ppy_swday_net_val,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_net_val,
   FSRC.perf_adj_return_net_val,
   SUM(COALESCE(FSRC.perf_adj_return_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_net_val,
   t2.perf_adj_return_py_net_val,
   SUM(t6.perf_adj_return_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_net_val,
   t10.perf_adj_return_swday_net_val,
   SUM(t14.perf_adj_return_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_net_val,
   t18.perf_adj_return_ppy_net_val,
   SUM(t22.perf_adj_return_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_net_val,
   t26.perf_adj_return_ppy_swday_net_val,
   SUM(t30.perf_adj_return_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_net_val,
   COALESCE(FSRC.uom_cd, '@') AS uom_cd,
   FSRC.turnover_net_val,
   SUM(COALESCE(FSRC.turnover_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val
   ,
   t2.turnover_py_net_val,
   SUM(t6.turnover_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_bytd_net_val,
   t10.turnover_py_swday_net_val,
   SUM(t14.turnover_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_swday_bytd_net_val,
   t18.turnover_ppy_net_val,
   SUM(t22.turnover_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_bytd_net_val,
   t26.turnover_ppy_swday_net_val,
   SUM(t30.turnover_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_swday_bytd_net_val,
   FSRC.plan_turnover_net_val,
   SUM(COALESCE(FSRC.plan_turnover_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_bytd_net_val,
   t2.plan_turnover_py_net_val,
   SUM(t6.plan_turnover_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_py_bytd_net_val,
   t10.plan_turnover_py_swday_net_val,
   SUM(t14.plan_turnover_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_py_swday_bytd_net_val,
   t18.plan_turnover_ppy_net_val,
   SUM(t22.plan_turnover_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_ppy_bytd_net_val,
   t26.plan_turnover_ppy_swday_net_val,
   SUM(t30.plan_turnover_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_ppy_swday_bytd_net_val,
   FSRC.cash_register_sales_net_val,
   SUM(COALESCE(FSRC.cash_register_sales_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_bytd_net_val,
   t2.cash_register_sales_py_net_val,
   SUM(t6.cash_register_sales_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_py_bytd_net_val,
   t10.cash_register_sales_py_swday_net_val,
   SUM(t14.cash_register_sales_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_py_swday_bytd_net_val,
   t18.cash_register_sales_ppy_net_val,
   SUM(t22.cash_register_sales_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_ppy_bytd_net_val,
   t26.cash_register_sales_ppy_swday_net_val,
   SUM(t30.cash_register_sales_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_ppy_swday_bytd_net_val,
   FSRC.cash_register_return_net_val,
   SUM(COALESCE(FSRC.cash_register_return_net_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_bytd_net_val,
   t2.cash_register_return_py_net_val,
   SUM(t6.cash_register_return_py_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_py_bytd_net_val,
   t10.cash_register_return_py_swday_net_val,
   SUM(t14.cash_register_return_py_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_py_swday_bytd_net_val,
   t18.cash_register_return_ppy_net_val,
   SUM(t22.cash_register_return_ppy_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_ppy_bytd_net_val,
   t26.cash_register_return_ppy_swday_net_val,
   SUM(t30.cash_register_return_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_ppy_swday_bytd_net_val,
   FSRC.eod_turnover_net_val,
   FSRC.booked_turnover_net_val,
   FSRC.turnover_gross_val,
   SUM(COALESCE(FSRC.turnover_gross_val, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_bytd_gross_val,
   t2.turnover_py_gross_val,
   SUM(t6.turnover_py_bytd_gross_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_bytd_gross_val,
   t10.turnover_py_swday_gross_val,
   SUM(t14.turnover_py_swday_bytd_gross_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_swday_bytd_gross_val,
   t18.turnover_ppy_gross_val,
   SUM(t22.turnover_ppy_bytd_gross_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_bytd_gross_val,
   t26.turnover_ppy_swday_gross_val,
   SUM(t30.turnover_ppy_swday_bytd_gross_val) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_swday_bytd_gross_val,
   FSRC.cash_register_sales_gross_val,
   FSRC.cash_register_return_gross_val,
   FSRC.eod_turnover_gross_val,
   SRC.curr_cd,
   FSRC.receipt_cnt,
   SUM(COALESCE(FSRC.receipt_cnt, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_bytd_cnt,
   t2.receipt_py_cnt,
   SUM(t6.receipt_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING) ORDER BY
      SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_bytd_cnt,
   t10.receipt_py_swday_cnt,
   SUM(t14.receipt_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   receipt_py_swday_bytd_cnt,
   t18.receipt_ppy_cnt,
   SUM(t22.receipt_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_ppy_bytd_cnt,
   t26.receipt_ppy_swday_cnt,
   SUM(t30.receipt_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   receipt_ppy_swday_bytd_cnt,
   FSRC.cash_register_receipt_cnt,
   FSRC.eod_receipt_cnt,
   FSRC.booked_receipt_cnt,
   FSRC.plan_receipt_cnt,
   SUM(COALESCE(FSRC.plan_receipt_cnt, 0)) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_receipt_bytd_cnt
   ,
   t2.plan_receipt_py_cnt,
   SUM(t6.plan_receipt_py_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_py_bytd_cnt,
   t10.plan_receipt_py_swday_cnt,
   SUM(t14.plan_receipt_py_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_py_swday_bytd_cnt,
   t18.plan_receipt_ppy_cnt,
   SUM(t22.plan_receipt_ppy_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
    ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_ppy_bytd_cnt,
   t26.plan_receipt_ppy_swday_cnt,
   SUM(t30.plan_receipt_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(SRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_ppy_swday_bytd_cnt,
   NULL AS plan_total_hr_cnt,
   NULL AS plan_total_hr_bytd_cnt,
   FSRC.short_term_plan_total_hr_cnt,
   SUM(FSRC.short_term_plan_total_hr_cnt) OVER (PARTITION BY CAST(FSRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   short_term_plan_total_hr_bytd_cnt,
   FSRC.short_term_plan_perf_adj_sales_qty,
   SUM(FSRC.short_term_plan_perf_adj_sales_qty) OVER (PARTITION BY CAST(FSRC.int_org_sid AS STRING), CAST(SRC.bus_year AS STRING)
      ORDER BY SRC.cal_dt IS NULL, SRC.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   short_term_plan_perf_adj_sales_bytd_qty,
   COALESCE(FSRC.dwh_created_tmsp, CURRENT_TIMESTAMP()) AS dwh_created_tmsp,
   COALESCE(FSRC.dwh_updated_tmsp, CURRENT_TIMESTAMP()) AS dwh_updated_tmsp,
   COALESCE(FSRC.dwh_load_id, 1) AS dwh_load_id,
   COALESCE(FSRC.dwh_node_cd, 'CORE_REL') AS dwh_node_cd
  FROM ldl_data_etl.v_fact_turnover_fulldates AS SRC
   LEFT JOIN ldl_data_etl.t_tcache_fact_retail_by_store_day AS FSRC ON SRC.cal_dt = FSRC.bus_dt AND SRC.int_org_sid =
     FSRC.int_org_sid
   LEFT JOIN PY AS t2 ON SRC.cal_dt = t2.cal_dt AND SRC.int_org_sid = t2.int_org_sid
   LEFT JOIN PYBD AS t6 ON SRC.cal_dt = t6.cal_dt AND SRC.int_org_sid = t6.int_org_sid
   LEFT JOIN PYSW AS t10 ON SRC.cal_dt = t10.cal_dt AND SRC.int_org_sid = t10.int_org_sid
   LEFT JOIN PYSWBD AS t14 ON SRC.cal_dt = t14.cal_dt AND SRC.int_org_sid = t14.int_org_sid
   LEFT JOIN PPY AS t18 ON SRC.cal_dt = t18.cal_dt AND SRC.int_org_sid = t18.int_org_sid
   LEFT JOIN PPYBD AS t22 ON SRC.cal_dt = t22.cal_dt AND SRC.int_org_sid = t22.int_org_sid
   LEFT JOIN PPYSW AS t26 ON SRC.cal_dt = t26.cal_dt AND SRC.int_org_sid = t26.int_org_sid
   LEFT JOIN PPYSWBD AS t30 ON SRC.cal_dt = t30.cal_dt AND SRC.int_org_sid = t30.int_org_sid);