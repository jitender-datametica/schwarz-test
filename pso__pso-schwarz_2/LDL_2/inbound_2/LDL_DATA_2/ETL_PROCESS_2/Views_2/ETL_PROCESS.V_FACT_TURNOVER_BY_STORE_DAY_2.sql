CREATE OR REPLACE VIEW ETL_PROCESS.V_FACT_TURNOVER_BY_STORE_DAY_2(
    BUS_DT
  , INT_ORG_SID
  , INT_ORG_TYPE_CD
  , COUNTRY_ORG_CD
  , TURNOVER_NET_VAL
  , TURNOVER_BYTD_NET_VAL
  , TURNOVER_PY_NET_VAL
  , TURNOVER_PY_BYTD_NET_VAL
  , TURNOVER_PY_SWDAY_NET_VAL
  , TURNOVER_PY_SWDAY_BYTD_NET_VAL
  , CASH_REGISTER_TURNOVER_NET_VAL
  , EOD_TURNOVER_NET_VAL
  , BOOKED_TURNOVER_NET_VAL
  , PLAN_TURNOVER_NET_VAL
  , PLAN_TURNOVER_BYTD_NET_VAL
  , PLAN_TURNOVER_PY_NET_VAL
  , PLAN_TURNOVER_PY_BYTD_NET_VAL
  , PLAN_TURNOVER_PY_SWDAY_NET_VAL
  , PLAN_TURNOVER_PY_SWDAY_BYTD_NET_VAL
  , TURNOVER_GROSS_VAL
  , TURNOVER_BYTD_GROSS_VAL
  , TURNOVER_PY_GROSS_VAL
  , TURNOVER_PY_BYTD_GROSS_VAL
  , TURNOVER_PY_SWDAY_GROSS_VAL
  , TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
  , CASH_REGISTER_TURNOVER_GROSS_VAL
  , EOD_TURNOVER_GROSS_VAL
  , CURR_CD
  , RECEIPT_CNT
  , RECEIPT_BYTD_CNT
  , RECEIPT_PY_CNT
  , RECEIPT_PY_BYTD_CNT
  , RECEIPT_PY_SWDAY_CNT
  , RECEIPT_PY_SWDAY_BYTD_CNT
  , CASH_REGISTER_RECEIPT_CNT
  , EOD_RECEIPT_CNT
  , BOOKED_RECEIPT_CNT
  , PLAN_RECEIPT_CNT
  , PLAN_RECEIPT_BYTD_CNT
  , PLAN_RECEIPT_PY_CNT
  , PLAN_RECEIPT_PY_BYTD_CNT
  , PLAN_RECEIPT_PY_SWDAY_CNT
  , PLAN_RECEIPT_PY_SWDAY_BYTD_CNT
  , DWH_CREATED_TMSP
  , DWH_UPDATED_TMSP
  , DWH_LOAD_ID
  , DWH_NODE_CD
  , SALES_NET_VAL
  , SALES_BYTD_NET_VAL
  , SALES_PY_NET_VAL
  , SALES_PY_BYTD_NET_VAL
  , SALES_PY_SWDAY_NET_VAL
  , SALES_PY_SWDAY_BYTD_NET_VAL
  , RETURN_NET_VAL
  , RETURN_BYTD_NET_VAL
  , RETURN_PY_NET_VAL
  , RETURN_PY_BYTD_NET_VAL
  , RETURN_PY_SWDAY_NET_VAL
  , RETURN_PY_SWDAY_BYTD_NET_VAL
  , SALES_VARIANT_SALES_CNT
  , SALES_VARIANT_SALES_BYTD_CNT
  , SALES_VARIANT_SALES_PY_CNT
  , SALES_VARIANT_SALES_PY_BYTD_CNT
  , SALES_VARIANT_SALES_PY_SWDAY_CNT
  , SALES_VARIANT_SALES_PY_SWDAY_BYTD_CNT
  , SALES_VARIANT_SALES_QTY
  , SALES_VARIANT_SALES_BYTD_QTY
  , SALES_VARIANT_SALES_PY_QTY
  , SALES_VARIANT_SALES_PY_BYTD_QTY
  , SALES_VARIANT_SALES_PY_SWDAY_QTY
  , SALES_VARIANT_SALES_PY_SWDAY_BYTD_QTY
  , SALES_VARIANT_RETURN_CNT
  , SALES_VARIANT_RETURN_BYTD_CNT
  , SALES_VARIANT_RETURN_PY_CNT
  , SALES_VARIANT_RETURN_PY_BYTD_CNT
  , SALES_VARIANT_RETURN_PY_SWDAY_CNT
  , SALES_VARIANT_RETURN_PY_SWDAY_BYTD_CNT
  , SALES_VARIANT_RETURN_QTY
  , SALES_VARIANT_RETURN_BYTD_QTY
  , SALES_VARIANT_RETURN_PY_QTY
  , SALES_VARIANT_RETURN_PY_BYTD_QTY
  , SALES_VARIANT_RETURN_PY_SWDAY_QTY
  , SALES_VARIANT_RETURN_PY_SWDAY_BYTD_QTY
  ,  SALES_VARIANT_PERF_TOTAL_CNT
  ,  SALES_VARIANT_PERF_TOTAL_BYTD_CNT
  ,  SALES_VARIANT_PERF_TOTAL_PY_CNT
  ,  SALES_VARIANT_PERF_TOTAL_PY_BYTD_CNT
  ,  SALES_VARIANT_PERF_TOTAL_PY_SWDAY_CNT
  ,  SALES_VARIANT_PERF_TOTAL_PY_SWDAY_BYTD_CNT
  ,  SALES_VARIANT_PERF_TOTAL_QTY
  ,  SALES_VARIANT_PERF_TOTAL_BYTD_QTY
  ,  SALES_VARIANT_PERF_TOTAL_PY_QTY
  ,  SALES_VARIANT_PERF_TOTAL_PY_BYTD_QTY
  ,  SALES_VARIANT_PERF_TOTAL_PY_SWDAY_QTY
  ,  SALES_VARIANT_PERF_TOTAL_PY_SWDAY_BYTD_QTY
) AS
SELECT src.cal_dt AS bus_dt
     , src.int_org_sid
     , src.int_org_type_cd
     , src.country_org_cd
     , fsrc.turnover_net_val
     , Sum(Coalesce(fsrc.turnover_net_val, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                            ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val
     , py.turnover_py_net_val
     , pybd.turnover_py_bytd_net_val
     , pysw.turnover_py_swday_net_val
     , pyswbd.turnover_py_swday_bytd_net_val
     , fsrc.cash_register_turnover_net_val
     , fsrc.eod_turnover_net_val
     , fsrc.booked_turnover_net_val
     , fsrc.plan_turnover_net_val
     , Sum(Coalesce(fsrc.plan_turnover_net_val, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                            ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_turnover_bytd_net_val
     , py.plan_turnover_py_net_val
     , pybd.plan_turnover_py_bytd_net_val
     , pysw.plan_turnover_py_swday_net_val
     , pyswbd.plan_turnover_py_swday_bytd_net_val
     , fsrc.turnover_gross_val
     , Sum(Coalesce(fsrc.turnover_gross_val, 0)) OVER (PARTITION BY fsrc.int_org_sid, src.bus_year
                                              ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_gross_val
     , py.turnover_py_gross_val
     , pybd.turnover_py_bytd_gross_val
     , pysw.turnover_py_swday_gross_val
     , pyswbd.turnover_py_swday_bytd_gross_val
     , fsrc.cash_register_turnover_gross_val
     , fsrc.eod_turnover_gross_val
     , src.curr_cd
     , fsrc.receipt_cnt
     , Sum(Coalesce(fsrc.receipt_cnt, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                      ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_bytd_cnt
     , py.receipt_py_cnt
     , pybd.receipt_py_bytd_cnt
     , pysw.receipt_py_swday_cnt
     , pyswbd.receipt_py_swday_bytd_cnt
     , fsrc.cash_register_receipt_cnt
     , fsrc.eod_receipt_cnt
     , fsrc.booked_receipt_cnt
     , fsrc.plan_receipt_cnt
     , Sum(Coalesce(fsrc.plan_receipt_cnt, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_receipt_bytd_cnt
     , py.plan_receipt_py_cnt
     , pybd.plan_receipt_py_bytd_cnt
     , pysw.plan_receipt_py_swday_cnt
     , pyswbd.plan_receipt_py_swday_bytd_cnt
     , Coalesce(fsrc.dwh_created_tmsp, CURRENT_TIMESTAMP) AS dwh_created_tmsp
     , Coalesce(fsrc.dwh_updated_tmsp, CURRENT_TIMESTAMP) AS dwh_updated_tmsp
     , Coalesce(fsrc.dwh_load_id, 1) AS dwh_load_id
     , Coalesce(fsrc.dwh_node_cd, 'CORE_REL') AS dwh_node_cd
     , fsrc.sales_net_val
     , Sum(Coalesce(fsrc.sales_net_val, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                            ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_bytd_net_val
     , py.sales_py_net_val
     , pybd.sales_py_bytd_net_val
     , pysw.sales_py_swday_net_val
     , pyswbd.sales_py_swday_bytd_net_val
     , fsrc.return_net_val
     , Sum(Coalesce(fsrc.return_net_val, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                            ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS return_bytd_net_val
     , py.return_py_net_val
     , pybd.return_py_bytd_net_val
     , pysw.return_py_swday_net_val
     , pyswbd.return_py_swday_bytd_net_val
     , fsrc.sales_variant_sales_cnt
     , Sum(Coalesce(fsrc.sales_variant_sales_cnt, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_sales_bytd_cnt
     , py.sales_variant_sales_py_cnt
     , pybd.sales_variant_sales_py_bytd_cnt
     , pysw.sales_variant_sales_py_swday_cnt
     , pyswbd.sales_variant_sales_py_swday_bytd_cnt
     , fsrc.sales_variant_sales_qty
     , Sum(Coalesce(fsrc.sales_variant_sales_qty, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_sales_bytd_qty
     , py.sales_variant_sales_py_qty
     , pybd.sales_variant_sales_py_bytd_qty
     , pysw.sales_variant_sales_py_swday_qty
     , pyswbd.sales_variant_sales_py_swday_bytd_qty
     , fsrc.sales_variant_return_cnt
     , Sum(Coalesce(fsrc.sales_variant_return_cnt, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_return_bytd_cnt
     , py.sales_variant_return_py_cnt
     , pybd.sales_variant_return_py_bytd_cnt
     , pysw.sales_variant_return_py_swday_cnt
     , pyswbd.sales_variant_return_py_swday_bytd_cnt
     , fsrc.sales_variant_return_qty
     , Sum(Coalesce(fsrc.sales_variant_return_qty, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_return_bytd_qty
     , py.sales_variant_return_py_qty
     , pybd.sales_variant_return_py_bytd_qty
     , pysw.sales_variant_return_py_swday_qty
     , pyswbd.sales_variant_return_py_swday_bytd_qty
     , fsrc.sales_variant_perf_total_cnt
     , Sum(Coalesce(fsrc.sales_variant_perf_total_cnt, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_perf_total_bytd_cnt
     , py.sales_variant_perf_total_py_cnt
     , pybd.sales_variant_perf_total_py_bytd_cnt
     , pysw.sales_variant_perf_total_py_swday_cnt
     , pyswbd.sales_variant_perf_total_py_swday_bytd_cnt
     , fsrc.sales_variant_perf_total_qty
     , Sum(Coalesce(fsrc.sales_variant_perf_total_qty, 0)) OVER (PARTITION BY src.int_org_sid, src.bus_year
                                           ORDER BY src.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sales_variant_perf_total_bytd_qty
     , py.sales_variant_perf_total_py_qty
     , pybd.sales_variant_perf_total_py_bytd_qty
     , pysw.sales_variant_perf_total_py_swday_qty
     , pyswbd.sales_variant_perf_total_py_swday_bytd_qty
  FROM ETL_PROCESS.v_fact_turnover_fulldates_2 AS src
  LEFT OUTER JOIN ETL.t_tcache_fact_turnover_by_store_day_2 AS fsrc
    ON src.cal_dt          = fsrc.bus_dt
   AND src.int_org_sid     = fsrc.int_org_sid
   AND src.int_org_type_cd = fsrc.int_org_type_cd
   AND src.country_org_cd  = fsrc.country_org_cd
  LEFT OUTER JOIN (SELECT dr.cal_dt
                  , src.int_org_sid
                  , Sum(src.turnover_net_val) AS turnover_py_net_val
                  , Sum(src.turnover_gross_val) AS turnover_py_gross_val
                  , Sum(src.receipt_cnt) AS receipt_py_cnt
                  , Sum(src.plan_turnover_net_val) AS plan_turnover_py_net_val
                  , Sum(src.plan_receipt_cnt) AS plan_receipt_py_cnt
                  , Sum(src.sales_net_val) AS sales_py_net_val
                  , Sum(src.return_net_val) AS return_py_net_val
                  , Sum(src.sales_variant_sales_cnt) AS sales_variant_sales_py_cnt
                  , Sum(src.sales_variant_return_cnt) AS sales_variant_return_py_cnt
                  , Sum(src.sales_variant_sales_qty) AS sales_variant_sales_py_qty
                  , Sum(src.sales_variant_return_qty) AS sales_variant_return_py_qty
                  , Sum(src.sales_variant_perf_total_cnt) AS sales_variant_perf_total_py_cnt
                  , Sum(src.sales_variant_perf_total_qty) AS sales_variant_perf_total_py_qty
               FROM ETL.t_tcache_fact_turnover_by_store_day_2 AS src
              INNER JOIN CORE_REL.t_cal_date_adjusted_relationship_2 AS dr
                 ON src.bus_dt = dr.rel_cal_dt
                AND dr.cal_dt_adjust_type_cd = 'M'
                AND dr.bus_year_diff = 1
              GROUP BY dr.cal_dt, src.int_org_sid) AS py
    ON src.cal_dt = py.cal_dt
   AND src.int_org_sid = py.int_org_sid
  LEFT OUTER JOIN (SELECT c1.cal_dt
                  , src.int_org_sid
                  , Sum(src.turnover_net_val) AS turnover_py_bytd_net_val
                  , Sum(src.turnover_gross_val) AS turnover_py_bytd_gross_val
                  , Sum(src.receipt_cnt) AS receipt_py_bytd_cnt
                  , Sum(src.plan_turnover_net_val) AS plan_turnover_py_bytd_net_val
                  , Sum(src.plan_receipt_cnt) AS plan_receipt_py_bytd_cnt
                  , Sum(src.sales_net_val) AS sales_py_bytd_net_val
                  , Sum(src.return_net_val) AS return_py_bytd_net_val
                  , Sum(src.sales_variant_sales_cnt) AS sales_variant_sales_py_bytd_cnt
                  , Sum(src.sales_variant_return_cnt) AS sales_variant_return_py_bytd_cnt
                  , Sum(src.sales_variant_sales_qty) AS sales_variant_sales_py_bytd_qty
                  , Sum(src.sales_variant_return_qty) AS sales_variant_return_py_bytd_qty
                  , Sum(src.sales_variant_perf_total_cnt) AS sales_variant_perf_total_py_bytd_cnt
                  , Sum(src.sales_variant_perf_total_qty) AS sales_variant_perf_total_py_bytd_qty
               FROM CORE_DIM.t_dim_calendar_date_2 AS c1
              INNER JOIN CORE_DIM.t_dim_calendar_date_2 AS c2
                 ON c1.bus_year = c2.bus_year
                AND c1.cal_dt  >= c2.cal_dt
              INNER JOIN CORE_REL.t_cal_date_adjusted_relationship_2 AS dr
                 ON c2.cal_dt = dr.cal_dt
                AND dr.cal_dt_adjust_type_cd = 'MC'
                AND dr.bus_year_diff = 1
              INNER JOIN ETL.t_tcache_fact_turnover_by_store_day_2 AS src
                 ON dr.rel_cal_dt = src.bus_dt
              GROUP BY c1.cal_dt, src.int_org_sid) AS pybd
    ON src.cal_dt = pybd.cal_dt
   AND src.int_org_sid = pybd.int_org_sid
  LEFT OUTER JOIN (SELECT dr.cal_dt
                  , src.int_org_sid
                  , Sum(src.turnover_net_val) AS turnover_py_swday_net_val
                  , Sum(src.turnover_gross_val) AS turnover_py_swday_gross_val
                  , Sum(src.receipt_cnt) AS receipt_py_swday_cnt
                  , Sum(src.plan_turnover_net_val) AS plan_turnover_py_swday_net_val
                  , Sum(src.plan_receipt_cnt) AS plan_receipt_py_swday_cnt
                  , Sum(src.sales_net_val) AS sales_py_swday_net_val
                  , Sum(src.return_net_val) AS return_py_swday_net_val
                  , Sum(src.sales_variant_sales_cnt) AS sales_variant_sales_py_swday_cnt
                  , Sum(src.sales_variant_return_cnt) AS sales_variant_return_py_swday_cnt
                  , Sum(src.sales_variant_sales_qty) AS sales_variant_sales_py_swday_qty
                  , Sum(src.sales_variant_return_qty) AS sales_variant_return_py_swday_qty
                  , Sum(src.sales_variant_perf_total_cnt) AS sales_variant_perf_total_py_swday_cnt
                  , Sum(src.sales_variant_perf_total_qty) AS sales_variant_perf_total_py_swday_qty
               FROM ETL.t_tcache_fact_turnover_by_store_day_2 AS src
              INNER JOIN CORE_REL.t_cal_date_adjusted_relationship_2 AS dr
                 ON src.bus_dt = dr.rel_cal_dt
                AND dr.cal_dt_adjust_type_cd = 'W'
                AND dr.bus_year_diff = 1
              GROUP BY dr.cal_dt, src.int_org_sid) AS pysw
    ON src.cal_dt = pysw.cal_dt
   AND src.int_org_sid = pysw.int_org_sid
  LEFT OUTER JOIN (SELECT c1.cal_dt
                  , src.int_org_sid
                  , Sum(src.turnover_net_val) AS turnover_py_swday_bytd_net_val
                  , Sum(src.turnover_gross_val) AS turnover_py_swday_bytd_gross_val
                  , Sum(src.receipt_cnt) AS receipt_py_swday_bytd_cnt
                  , Sum(src.plan_turnover_net_val) AS plan_turnover_py_swday_bytd_net_val
                  , Sum(src.plan_receipt_cnt) AS plan_receipt_py_swday_bytd_cnt
                  , Sum(src.sales_net_val) AS sales_py_swday_bytd_net_val
                  , Sum(src.return_net_val) AS return_py_swday_bytd_net_val
                  , Sum(src.sales_variant_sales_cnt) AS sales_variant_sales_py_swday_bytd_cnt
                  , Sum(src.sales_variant_return_cnt) AS sales_variant_return_py_swday_bytd_cnt
                  , Sum(src.sales_variant_sales_qty) AS sales_variant_sales_py_swday_bytd_qty
                  , Sum(src.sales_variant_return_qty) AS sales_variant_return_py_swday_bytd_qty
                  , Sum(src.sales_variant_perf_total_cnt) AS sales_variant_perf_total_py_swday_bytd_cnt
                  , Sum(src.sales_variant_perf_total_qty) AS sales_variant_perf_total_py_swday_bytd_qty
               FROM CORE_DIM.t_dim_calendar_date_2 AS c1
              INNER JOIN CORE_DIM.t_dim_calendar_date_2 AS c2
                 ON c1.bus_year = c2.bus_year
                AND c1.cal_dt  >= c2.cal_dt
              INNER JOIN CORE_REL.t_cal_date_adjusted_relationship_2 AS dr
                 ON c2.cal_dt = dr.cal_dt
                AND dr.cal_dt_adjust_type_cd = 'WC'
                AND dr.bus_year_diff = 1
              INNER JOIN ETL.t_tcache_fact_turnover_by_store_day_2 AS src
                 ON dr.rel_cal_dt = src.bus_dt
              GROUP BY c1.cal_dt, src.int_org_sid) AS pyswbd
    ON src.cal_dt = pyswbd.cal_dt
   AND src.int_org_sid = pyswbd.int_org_sid
;