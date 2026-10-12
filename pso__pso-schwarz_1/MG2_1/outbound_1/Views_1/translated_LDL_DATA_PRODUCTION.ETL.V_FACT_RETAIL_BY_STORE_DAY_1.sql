CREATE OR REPLACE VIEW ldl_data_production_etl.v_fact_retail_by_store_day_1 AS WITH py AS (SELECT dr.cal_dt,
   src0.int_org_sid,
   SUM(src0.turnover_net_val) AS turnover_py_net_val,
   SUM(src0.turnover_gross_val) AS turnover_py_gross_val,
   SUM(src0.receipt_cnt) AS receipt_py_cnt,
   SUM(src0.plan_turnover_net_val) AS plan_turnover_py_net_val,
   SUM(src0.plan_receipt_cnt) AS plan_receipt_py_cnt,
   SUM(src0.sales_cnt) AS sales_py_cnt,
   SUM(src0.return_cnt) AS return_py_cnt,
   SUM(src0.sales_qty) AS sales_py_qty,
   SUM(src0.return_qty) AS return_py_qty,
   SUM(src0.perf_adj_return_cnt) AS perf_adj_return_py_cnt,
   SUM(src0.perf_adj_sales_cnt) AS perf_adj_sales_py_cnt,
   SUM(src0.perf_adj_sales_qty) AS perf_adj_sales_py_qty,
   SUM(src0.perf_adj_return_qty) AS perf_adj_return_py_qty,
   SUM(src0.perf_adj_sales_net_val) AS perf_adj_sales_py_net_val,
   SUM(src0.perf_adj_return_net_val) AS perf_adj_return_py_net_val,
   SUM(src0.cash_register_sales_net_val) AS cash_register_sales_py_net_val,
   SUM(src0.cash_register_return_net_val) AS cash_register_return_py_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src0
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr ON src0.bus_dt = dr.rel_cal_dt AND dr
      .cal_dt_adjust_type_cd = 'M' AND dr.bus_year_diff = 1
  GROUP BY src0.int_org_sid,
   dr.cal_dt), pybd AS (SELECT dr0.cal_dt,
   src1.int_org_sid,
   SUM(src1.turnover_net_val) AS turnover_py_bytd_net_val,
   SUM(src1.turnover_gross_val) AS turnover_py_bytd_gross_val,
   SUM(src1.receipt_cnt) AS receipt_py_bytd_cnt,
   SUM(src1.plan_turnover_net_val) AS plan_turnover_py_bytd_net_val,
   SUM(src1.plan_receipt_cnt) AS plan_receipt_py_bytd_cnt,
   SUM(src1.sales_cnt) AS sales_py_bytd_cnt,
   SUM(src1.return_cnt) AS return_py_bytd_cnt,
   SUM(src1.sales_qty) AS sales_py_bytd_qty,
   SUM(src1.return_qty) AS return_py_bytd_qty,
   SUM(src1.perf_adj_return_cnt) AS perf_adj_return_py_bytd_cnt,
   SUM(src1.perf_adj_sales_cnt) AS perf_adj_sales_py_bytd_cnt,
   SUM(src1.perf_adj_sales_qty) AS perf_adj_sales_py_bytd_qty,
   SUM(src1.perf_adj_return_qty) AS perf_adj_return_py_bytd_qty,
   SUM(src1.perf_adj_sales_net_val) AS perf_adj_sales_py_bytd_net_val,
   SUM(src1.perf_adj_return_net_val) AS perf_adj_return_py_bytd_net_val,
   SUM(src1.cash_register_sales_net_val) AS cash_register_sales_py_bytd_net_val,
   SUM(src1.cash_register_return_net_val) AS cash_register_return_py_bytd_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src1
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr0 ON src1.bus_dt = dr0.rel_cal_dt AND
      dr0.cal_dt_adjust_type_cd = 'MC' AND dr0.bus_year_diff = 1
  GROUP BY src1.int_org_sid,
   dr0.cal_dt), pysw AS (SELECT dr1.cal_dt,
   src2.int_org_sid,
   SUM(src2.turnover_net_val) AS turnover_py_swday_net_val,
   SUM(src2.turnover_gross_val) AS turnover_py_swday_gross_val,
   SUM(src2.receipt_cnt) AS receipt_py_swday_cnt,
   SUM(src2.plan_turnover_net_val) AS plan_turnover_py_swday_net_val,
   SUM(src2.plan_receipt_cnt) AS plan_receipt_py_swday_cnt,
   SUM(src2.sales_cnt) AS sales_py_swday_cnt,
   SUM(src2.return_cnt) AS return_py_swday_cnt,
   SUM(src2.sales_qty) AS sales_py_swday_qty,
   SUM(src2.return_qty) AS return_py_swday_qty,
   SUM(src2.perf_adj_return_cnt) AS perf_adj_return_swday_cnt,
   SUM(src2.perf_adj_sales_cnt) AS perf_adj_sales_swday_cnt,
   SUM(src2.perf_adj_sales_qty) AS perf_adj_sales_swday_qty,
   SUM(src2.perf_adj_return_qty) AS perf_adj_return_swday_qty,
   SUM(src2.perf_adj_sales_net_val) AS perf_adj_sales_swday_net_val,
   SUM(src2.perf_adj_return_net_val) AS perf_adj_return_swday_net_val,
   SUM(src2.cash_register_sales_net_val) AS cash_register_sales_py_swday_net_val,
   SUM(src2.cash_register_return_net_val) AS cash_register_return_py_swday_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src2
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr1 ON src2.bus_dt = dr1.rel_cal_dt AND
      dr1.cal_dt_adjust_type_cd = 'W' AND dr1.bus_year_diff = 1
  GROUP BY src2.int_org_sid,
   dr1.cal_dt), pyswbd AS (SELECT dr2.cal_dt,
   src3.int_org_sid,
   SUM(src3.turnover_net_val) AS turnover_py_swday_bytd_net_val,
   SUM(src3.turnover_gross_val) AS turnover_py_swday_bytd_gross_val,
   SUM(src3.receipt_cnt) AS receipt_py_swday_bytd_cnt,
   SUM(src3.plan_turnover_net_val) AS plan_turnover_py_swday_bytd_net_val,
   SUM(src3.plan_receipt_cnt) AS plan_receipt_py_swday_bytd_cnt,
   SUM(src3.sales_cnt) AS sales_py_swday_bytd_cnt,
   SUM(src3.return_cnt) AS return_py_swday_bytd_cnt,
   SUM(src3.sales_qty) AS sales_py_swday_bytd_qty,
   SUM(src3.return_qty) AS return_py_swday_bytd_qty,
   SUM(src3.perf_adj_return_cnt) AS perf_adj_return_py_swday_bytd_cnt,
   SUM(src3.perf_adj_sales_cnt) AS perf_adj_sales_py_swday_bytd_cnt,
   SUM(src3.perf_adj_sales_qty) AS perf_adj_sales_py_swday_bytd_qty,
   SUM(src3.perf_adj_return_qty) AS perf_adj_return_py_swday_bytd_qty,
   SUM(src3.perf_adj_sales_net_val) AS perf_adj_sales_py_swday_bytd_net_val,
   SUM(src3.perf_adj_return_net_val) AS perf_adj_return_py_swday_bytd_net_val,
   SUM(src3.cash_register_sales_net_val) AS cash_register_sales_py_swday_bytd_net_val,
   SUM(src3.cash_register_return_net_val) AS cash_register_return_py_swday_bytd_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src3
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr2 ON src3.bus_dt = dr2.rel_cal_dt AND
      dr2.cal_dt_adjust_type_cd = 'WC' AND dr2.bus_year_diff = 1
  GROUP BY src3.int_org_sid,
   dr2.cal_dt), ppy AS (SELECT dr3.cal_dt,
   src4.int_org_sid,
   SUM(src4.turnover_net_val) AS turnover_ppy_net_val,
   SUM(src4.turnover_gross_val) AS turnover_ppy_gross_val,
   SUM(src4.receipt_cnt) AS receipt_ppy_cnt,
   SUM(src4.plan_turnover_net_val) AS plan_turnover_ppy_net_val,
   SUM(src4.plan_receipt_cnt) AS plan_receipt_ppy_cnt,
   SUM(src4.sales_cnt) AS sales_ppy_cnt,
   SUM(src4.return_cnt) AS return_ppy_cnt,
   SUM(src4.sales_qty) AS sales_ppy_qty,
   SUM(src4.return_qty) AS return_ppy_qty,
   SUM(src4.perf_adj_return_cnt) AS perf_adj_return_ppy_cnt,
   SUM(src4.perf_adj_sales_cnt) AS perf_adj_sales_ppy_cnt,
   SUM(src4.perf_adj_sales_qty) AS perf_adj_sales_ppy_qty,
   SUM(src4.perf_adj_return_qty) AS perf_adj_return_ppy_qty,
   SUM(src4.perf_adj_sales_net_val) AS perf_adj_sales_ppy_net_val,
   SUM(src4.perf_adj_return_net_val) AS perf_adj_return_ppy_net_val,
   SUM(src4.cash_register_sales_net_val) AS cash_register_sales_ppy_net_val,
   SUM(src4.cash_register_return_net_val) AS cash_register_return_ppy_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src4
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr3 ON src4.bus_dt = dr3.rel_cal_dt AND
      dr3.cal_dt_adjust_type_cd = 'M' AND dr3.bus_year_diff = 2
  GROUP BY src4.int_org_sid,
   dr3.cal_dt), ppybd AS (SELECT dr4.cal_dt,
   src5.int_org_sid,
   SUM(src5.turnover_net_val) AS turnover_ppy_bytd_net_val,
   SUM(src5.turnover_gross_val) AS turnover_ppy_bytd_gross_val,
   SUM(src5.receipt_cnt) AS receipt_ppy_bytd_cnt,
   SUM(src5.plan_turnover_net_val) AS plan_turnover_ppy_bytd_net_val,
   SUM(src5.plan_receipt_cnt) AS plan_receipt_ppy_bytd_cnt,
   SUM(src5.sales_cnt) AS sales_ppy_bytd_cnt,
   SUM(src5.return_cnt) AS return_ppy_bytd_cnt,
   SUM(src5.sales_qty) AS sales_ppy_bytd_qty,
   SUM(src5.return_qty) AS return_ppy_bytd_qty,
   SUM(src5.perf_adj_return_cnt) AS perf_adj_return_ppy_bytd_cnt,
   SUM(src5.perf_adj_sales_cnt) AS perf_adj_sales_ppy_bytd_cnt,
   SUM(src5.perf_adj_sales_qty) AS perf_adj_sales_ppy_bytd_qty,
   SUM(src5.perf_adj_return_qty) AS perf_adj_return_ppy_bytd_qty,
   SUM(src5.perf_adj_sales_net_val) AS perf_adj_sales_ppy_bytd_net_val,
   SUM(src5.perf_adj_return_net_val) AS perf_adj_return_ppy_bytd_net_val,
   SUM(src5.cash_register_sales_net_val) AS cash_register_sales_ppy_bytd_net_val,
   SUM(src5.cash_register_return_net_val) AS cash_register_return_ppy_bytd_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src5
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr4 ON src5.bus_dt = dr4.rel_cal_dt AND
      dr4.cal_dt_adjust_type_cd = 'MC' AND dr4.bus_year_diff = 2
  GROUP BY src5.int_org_sid,
   dr4.cal_dt), ppysw AS (SELECT dr5.cal_dt,
   src6.int_org_sid,
   SUM(src6.turnover_net_val) AS turnover_ppy_swday_net_val,
   SUM(src6.turnover_gross_val) AS turnover_ppy_swday_gross_val,
   SUM(src6.receipt_cnt) AS receipt_ppy_swday_cnt,
   SUM(src6.plan_turnover_net_val) AS plan_turnover_ppy_swday_net_val,
   SUM(src6.plan_receipt_cnt) AS plan_receipt_ppy_swday_cnt,
   SUM(src6.sales_cnt) AS sales_ppy_swday_cnt,
   SUM(src6.return_cnt) AS return_ppy_swday_cnt,
   SUM(src6.sales_qty) AS sales_ppy_swday_qty,
   SUM(src6.return_qty) AS return_ppy_swday_qty,
   SUM(src6.perf_adj_return_cnt) AS perf_adj_return_ppy_swday_cnt,
   SUM(src6.perf_adj_sales_cnt) AS perf_adj_sales_ppy_swday_cnt,
   SUM(src6.perf_adj_sales_qty) AS perf_adj_sales_ppy_swday_qty,
   SUM(src6.perf_adj_return_qty) AS perf_adj_return_ppy_swday_qty,
   SUM(src6.perf_adj_sales_net_val) AS perf_adj_sales_ppy_swday_net_val,
   SUM(src6.perf_adj_return_net_val) AS perf_adj_return_ppy_swday_net_val,
   SUM(src6.cash_register_sales_net_val) AS cash_register_sales_ppy_swday_net_val,
   SUM(src6.cash_register_return_net_val) AS cash_register_return_ppy_swday_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src6
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr5 ON src6.bus_dt = dr5.rel_cal_dt AND
      dr5.cal_dt_adjust_type_cd = 'W' AND dr5.bus_year_diff = 2
  GROUP BY src6.int_org_sid,
   dr5.cal_dt), ppyswbd AS (SELECT dr6.cal_dt,
   src7.int_org_sid,
   SUM(src7.turnover_net_val) AS turnover_ppy_swday_bytd_net_val,
   SUM(src7.turnover_gross_val) AS turnover_ppy_swday_bytd_gross_val,
   SUM(src7.receipt_cnt) AS receipt_ppy_swday_bytd_cnt,
   SUM(src7.plan_turnover_net_val) AS plan_turnover_ppy_swday_bytd_net_val,
   SUM(src7.plan_receipt_cnt) AS plan_receipt_ppy_swday_bytd_cnt,
   SUM(src7.sales_cnt) AS sales_ppy_swday_bytd_cnt,
   SUM(src7.return_cnt) AS return_ppy_swday_bytd_cnt,
   SUM(src7.sales_qty) AS sales_ppy_swday_bytd_qty,
   SUM(src7.return_qty) AS return_ppy_swday_bytd_qty,
   SUM(src7.perf_adj_return_cnt) AS perf_adj_return_ppy_swday_bytd_cnt,
   SUM(src7.perf_adj_sales_cnt) AS perf_adj_sales_ppy_swday_bytd_cnt,
   SUM(src7.perf_adj_sales_qty) AS perf_adj_sales_ppy_swday_bytd_qty,
   SUM(src7.perf_adj_return_qty) AS perf_adj_return_ppy_swday_bytd_qty,
   SUM(src7.perf_adj_sales_net_val) AS perf_adj_sales_ppy_swday_bytd_net_val,
   SUM(src7.perf_adj_return_net_val) AS perf_adj_return_ppy_swday_bytd_net_val,
   SUM(src7.cash_register_sales_net_val) AS cash_register_sales_ppy_swday_bytd_net_val,
   SUM(src7.cash_register_return_net_val) AS cash_register_return_ppy_swday_bytd_net_val
  FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS src7
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS dr6 ON src7.bus_dt = dr6.rel_cal_dt AND
      dr6.cal_dt_adjust_type_cd = 'WC' AND dr6.bus_year_diff = 2
  GROUP BY src7.int_org_sid,
   dr6.cal_dt) (SELECT src.cal_dt AS bus_dt,
   src.int_org_sid,
   src.int_org_type_cd,
   src.country_org_cd,
   fsrc.sales_cnt,
   SUM(fsrc.sales_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY src.cal_dt
      IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_cnt,
   t2.sales_py_cnt,
   SUM(t6.sales_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_bytd_cnt,
   t10.sales_py_swday_cnt,
   SUM(t14.sales_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_swday_bytd_cnt
   ,
   t18.sales_ppy_cnt,
   SUM(t22.sales_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_ppy_bytd_cnt,
   t26.sales_ppy_swday_cnt,
   SUM(t30.sales_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sales_ppy_swday_bytd_cnt,
   fsrc.sales_qty,
   SUM(fsrc.sales_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY src.cal_dt
      IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_qty,
   t2.sales_py_qty,
   SUM(t6.sales_py_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_bytd_qty,
   t10.sales_py_swday_qty,
   SUM(t14.sales_py_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_py_swday_bytd_qty
   ,
   t18.sales_ppy_qty,
   SUM(t22.sales_ppy_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_ppy_bytd_qty,
   t26.sales_ppy_swday_qty,
   SUM(t30.sales_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   sales_ppy_swday_bytd_qty,
   fsrc.return_cnt,
   SUM(COALESCE(fsrc.return_cnt, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_cnt,
   t2.return_py_cnt,
   SUM(t6.return_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_py_bytd_cnt,
   t10.return_py_swday_cnt,
   SUM(t14.return_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_py_swday_bytd_cnt,
   t18.return_ppy_cnt,
   SUM(t22.return_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_ppy_bytd_cnt,
   t26.return_ppy_swday_cnt,
   SUM(t30.return_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_ppy_swday_bytd_cnt,
   fsrc.return_qty,
   SUM(COALESCE(fsrc.return_qty, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_qty,
   t2.return_py_qty,
   SUM(t6.return_py_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_py_bytd_qty,
   t10.return_py_swday_qty,
   SUM(t14.return_py_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_py_swday_bytd_qty,
   t18.return_ppy_qty,
   SUM(t22.return_ppy_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_ppy_bytd_qty,
   t26.return_ppy_swday_qty,
   SUM(t30.return_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   return_ppy_swday_bytd_qty,
   fsrc.perf_adj_sales_cnt,
   SUM(COALESCE(fsrc.perf_adj_sales_cnt, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_cnt,
   t2.perf_adj_sales_py_cnt,
   SUM(t6.perf_adj_sales_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_cnt,
   t10.perf_adj_sales_swday_cnt,
   SUM(t14.perf_adj_sales_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_cnt,
   t18.perf_adj_sales_ppy_cnt,
   SUM(t22.perf_adj_sales_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_cnt,
   t26.perf_adj_sales_ppy_swday_cnt,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_cnt,
   fsrc.perf_adj_sales_qty,
   SUM(COALESCE(fsrc.perf_adj_sales_qty, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_qty,
   t2.perf_adj_sales_py_qty,
   SUM(t6.perf_adj_sales_py_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_qty,
   t10.perf_adj_sales_swday_qty,
   SUM(t14.perf_adj_sales_py_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_qty,
   t18.perf_adj_sales_ppy_qty,
   SUM(t22.perf_adj_sales_ppy_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_qty,
   t26.perf_adj_sales_ppy_swday_qty,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_qty,
   fsrc.perf_adj_return_cnt,
   SUM(COALESCE(fsrc.perf_adj_return_cnt, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_cnt,
   t2.perf_adj_return_py_cnt,
   SUM(t6.perf_adj_return_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_cnt,
   t10.perf_adj_return_swday_cnt,
   SUM(t14.perf_adj_return_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_cnt,
   t18.perf_adj_return_ppy_cnt,
   SUM(t22.perf_adj_return_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_cnt,
   t26.perf_adj_return_ppy_swday_cnt,
   SUM(t30.perf_adj_return_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_cnt,
   fsrc.perf_adj_return_qty,
   SUM(COALESCE(fsrc.perf_adj_return_qty, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_qty,
   t2.perf_adj_return_py_qty,
   SUM(t6.perf_adj_return_py_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_qty,
   t10.perf_adj_return_swday_qty,
   SUM(t14.perf_adj_return_py_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_qty,
   t18.perf_adj_return_ppy_qty,
   SUM(t22.perf_adj_return_ppy_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_qty,
   t26.perf_adj_return_ppy_swday_qty,
   SUM(t30.perf_adj_return_ppy_swday_bytd_qty) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_qty,
   fsrc.perf_adj_sales_net_val,
   SUM(COALESCE(fsrc.perf_adj_sales_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_bytd_net_val,
   t2.perf_adj_sales_py_net_val,
   SUM(t6.perf_adj_sales_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_bytd_net_val,
   t10.perf_adj_sales_swday_net_val,
   SUM(t14.perf_adj_sales_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_py_swday_bytd_net_val,
   t18.perf_adj_sales_ppy_net_val,
   SUM(t22.perf_adj_sales_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_bytd_net_val,
   t26.perf_adj_sales_ppy_swday_net_val,
   SUM(t30.perf_adj_sales_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_sales_ppy_swday_bytd_net_val,
   fsrc.perf_adj_return_net_val,
   SUM(COALESCE(fsrc.perf_adj_return_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_bytd_net_val,
   t2.perf_adj_return_py_net_val,
   SUM(t6.perf_adj_return_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_bytd_net_val,
   t10.perf_adj_return_swday_net_val,
   SUM(t14.perf_adj_return_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_py_swday_bytd_net_val,
   t18.perf_adj_return_ppy_net_val,
   SUM(t22.perf_adj_return_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_bytd_net_val,
   t26.perf_adj_return_ppy_swday_net_val,
   SUM(t30.perf_adj_return_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   perf_adj_return_ppy_swday_bytd_net_val,
   COALESCE(fsrc.uom_cd, '@') AS uom_cd,
   fsrc.turnover_net_val,
   SUM(COALESCE(fsrc.turnover_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val
   ,
   t2.turnover_py_net_val,
   SUM(t6.turnover_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_bytd_net_val,
   t10.turnover_py_swday_net_val,
   SUM(t14.turnover_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_swday_bytd_net_val,
   t18.turnover_ppy_net_val,
   SUM(t22.turnover_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_bytd_net_val,
   t26.turnover_ppy_swday_net_val,
   SUM(t30.turnover_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_swday_bytd_net_val,
   fsrc.plan_turnover_net_val,
   SUM(COALESCE(fsrc.plan_turnover_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_bytd_net_val,
   t2.plan_turnover_py_net_val,
   SUM(t6.plan_turnover_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_py_bytd_net_val,
   t10.plan_turnover_py_swday_net_val,
   SUM(t14.plan_turnover_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_py_swday_bytd_net_val,
   t18.plan_turnover_ppy_net_val,
   SUM(t22.plan_turnover_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_ppy_bytd_net_val,
   t26.plan_turnover_ppy_swday_net_val,
   SUM(t30.plan_turnover_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_turnover_ppy_swday_bytd_net_val,
   fsrc.cash_register_sales_net_val,
   SUM(COALESCE(fsrc.cash_register_sales_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_bytd_net_val,
   t2.cash_register_sales_py_net_val,
   SUM(t6.cash_register_sales_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_py_bytd_net_val,
   t10.cash_register_sales_py_swday_net_val,
   SUM(t14.cash_register_sales_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_py_swday_bytd_net_val,
   t18.cash_register_sales_ppy_net_val,
   SUM(t22.cash_register_sales_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_ppy_bytd_net_val,
   t26.cash_register_sales_ppy_swday_net_val,
   SUM(t30.cash_register_sales_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_sales_ppy_swday_bytd_net_val,
   fsrc.cash_register_return_net_val,
   SUM(COALESCE(fsrc.cash_register_return_net_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_bytd_net_val,
   t2.cash_register_return_py_net_val,
   SUM(t6.cash_register_return_py_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_py_bytd_net_val,
   t10.cash_register_return_py_swday_net_val,
   SUM(t14.cash_register_return_py_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_py_swday_bytd_net_val,
   t18.cash_register_return_ppy_net_val,
   SUM(t22.cash_register_return_ppy_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_ppy_bytd_net_val,
   t26.cash_register_return_ppy_swday_net_val,
   SUM(t30.cash_register_return_ppy_swday_bytd_net_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cash_register_return_ppy_swday_bytd_net_val,
   fsrc.eod_turnover_net_val,
   fsrc.booked_turnover_net_val,
   fsrc.turnover_gross_val,
   SUM(COALESCE(fsrc.turnover_gross_val, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_bytd_gross_val,
   t2.turnover_py_gross_val,
   SUM(t6.turnover_py_bytd_gross_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_bytd_gross_val,
   t10.turnover_py_swday_gross_val,
   SUM(t14.turnover_py_swday_bytd_gross_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_py_swday_bytd_gross_val,
   t18.turnover_ppy_gross_val,
   SUM(t22.turnover_ppy_bytd_gross_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_bytd_gross_val,
   t26.turnover_ppy_swday_gross_val,
   SUM(t30.turnover_ppy_swday_bytd_gross_val) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_ppy_swday_bytd_gross_val,
   fsrc.cash_register_sales_gross_val,
   fsrc.cash_register_return_gross_val,
   fsrc.eod_turnover_gross_val,
   src.curr_cd,
   fsrc.receipt_cnt,
   SUM(COALESCE(fsrc.receipt_cnt, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_bytd_cnt,
   t2.receipt_py_cnt,
   SUM(t6.receipt_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING) ORDER BY
      src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_bytd_cnt,
   t10.receipt_py_swday_cnt,
   SUM(t14.receipt_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   receipt_py_swday_bytd_cnt,
   t18.receipt_ppy_cnt,
   SUM(t22.receipt_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_ppy_bytd_cnt,
   t26.receipt_ppy_swday_cnt,
   SUM(t30.receipt_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   receipt_ppy_swday_bytd_cnt,
   fsrc.cash_register_receipt_cnt,
   fsrc.eod_receipt_cnt,
   fsrc.booked_receipt_cnt,
   fsrc.plan_receipt_cnt,
   SUM(COALESCE(fsrc.plan_receipt_cnt, 0)) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_receipt_bytd_cnt
   ,
   t2.plan_receipt_py_cnt,
   SUM(t6.plan_receipt_py_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_py_bytd_cnt,
   t10.plan_receipt_py_swday_cnt,
   SUM(t14.plan_receipt_py_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_py_swday_bytd_cnt,
   t18.plan_receipt_ppy_cnt,
   SUM(t22.plan_receipt_ppy_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_ppy_bytd_cnt,
   t26.plan_receipt_ppy_swday_cnt,
   SUM(t30.plan_receipt_ppy_swday_bytd_cnt) OVER (PARTITION BY CAST(src.int_org_sid AS STRING), CAST(src.bus_year AS STRING)
      ORDER BY src.cal_dt IS NULL, src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   plan_receipt_ppy_swday_bytd_cnt,
   NULL AS plan_total_hr_cnt,
   NULL AS plan_total_hr_bytd_cnt,
   fsrc.short_term_plan_total_hr_cnt,
   SUM(fsrc.short_term_plan_total_hr_cnt) OVER (PARTITION BY fsrc.int_org_sid, CAST(src.bus_year AS STRING) ORDER BY src
      .cal_dt IS NULL, src.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   short_term_plan_total_hr_bytd_cnt,
   fsrc.short_term_plan_perf_adj_sales_qty,
   SUM(fsrc.short_term_plan_perf_adj_sales_qty) OVER (PARTITION BY fsrc.int_org_sid, CAST(src.bus_year AS STRING)
    ORDER BY src.cal_dt IS NULL, src.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   short_term_plan_perf_adj_sales_bytd_qty,
   COALESCE(fsrc.dwh_created_tmsp, CURRENT_TIMESTAMP()) AS dwh_created_tmsp,
   COALESCE(fsrc.dwh_updated_tmsp, CURRENT_TIMESTAMP()) AS dwh_updated_tmsp,
   COALESCE(fsrc.dwh_load_id, 1) AS dwh_load_id,
   COALESCE(fsrc.dwh_node_cd, 'CORE_REL') AS dwh_node_cd
  FROM ldl_data_production_etl.v_fact_turnover_fulldates_1 AS src
   LEFT JOIN ldl_data_production_etl.t_tcache_fact_retail_by_store_day_1 AS fsrc ON src.cal_dt = fsrc.bus_dt AND src.int_org_sid
      = fsrc.int_org_sid
   LEFT JOIN py AS t2 ON src.cal_dt = t2.cal_dt AND src.int_org_sid = t2.int_org_sid
   LEFT JOIN pybd AS t6 ON src.cal_dt = t6.cal_dt AND src.int_org_sid = t6.int_org_sid
   LEFT JOIN pysw AS t10 ON src.cal_dt = t10.cal_dt AND src.int_org_sid = t10.int_org_sid
   LEFT JOIN pyswbd AS t14 ON src.cal_dt = t14.cal_dt AND src.int_org_sid = t14.int_org_sid
   LEFT JOIN ppy AS t18 ON src.cal_dt = t18.cal_dt AND src.int_org_sid = t18.int_org_sid
   LEFT JOIN ppybd AS t22 ON src.cal_dt = t22.cal_dt AND src.int_org_sid = t22.int_org_sid
   LEFT JOIN ppysw AS t26 ON src.cal_dt = t26.cal_dt AND src.int_org_sid = t26.int_org_sid
   LEFT JOIN ppyswbd AS t30 ON src.cal_dt = t30.cal_dt AND src.int_org_sid = t30.int_org_sid);