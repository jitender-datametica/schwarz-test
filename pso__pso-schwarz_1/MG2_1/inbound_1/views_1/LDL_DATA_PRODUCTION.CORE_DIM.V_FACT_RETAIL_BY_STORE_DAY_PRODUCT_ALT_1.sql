create or replace view LDL_DATA_PRODUCTION.CORE_DIM.V_FACT_RETAIL_BY_STORE_DAY_PRODUCT_ALT_1(
	BUS_DT,
	STORE_SID,
	PROD_SID,
	SALES_VARIANT_SID,
	COUNTRY_ORG_SID,
	COUNTRY_ORG_CD,
	TOTAL_CNT,
	TOTAL_QTY,
	UOM_CD,
	TURNOVER_NET_VAL,
	TURNOVER_GROSS_VAL,
	CURR_CD,
	TURNOVER_BYTD_NET_VAL,
	TURNOVER_PY_NET_VAL,
	TURNOVER_PY_BYTD_NET_VAL,
	TURNOVER_PY_SWDAY_NET_VAL,
	TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	SALES_NET_VAL,
	SALES_BYTD_NET_VAL,
	SALES_PY_NET_VAL,
	SALES_PY_BYTD_NET_VAL,
	SALES_PY_SWDAY_NET_VAL,
	SALES_PY_SWDAY_BYTD_NET_VAL,
	RETURN_NET_VAL,
	RETURN_BYTD_NET_VAL,
	RETURN_PY_NET_VAL,
	RETURN_PY_BYTD_NET_VAL,
	RETURN_PY_SWDAY_NET_VAL,
	RETURN_PY_SWDAY_BYTD_NET_VAL,
	SALES_CNT,
	SALES_BYTD_CNT,
	SALES_PY_CNT,
	SALES_PY_BYTD_CNT,
	SALES_PY_SWDAY_CNT,
	SALES_PY_SWDAY_BYTD_CNT,
	SALES_QTY,
	SALES_BYTD_QTY,
	SALES_PY_QTY,
	SALES_PY_BYTD_QTY,
	SALES_PY_SWDAY_QTY,
	SALES_PY_SWDAY_BYTD_QTY,
	RETURN_CNT,
	RETURN_BYTD_CNT,
	RETURN_PY_CNT,
	RETURN_PY_BYTD_CNT,
	RETURN_PY_SWDAY_CNT,
	RETURN_PY_SWDAY_BYTD_CNT,
	RETURN_QTY,
	RETURN_BYTD_QTY,
	RETURN_PY_QTY,
	RETURN_PY_BYTD_QTY,
	RETURN_PY_SWDAY_QTY,
	RETURN_PY_SWDAY_BYTD_QTY,
	PERF_ADJ_TOTAL_CNT,
	PERF_ADJ_TOTAL_BYTD_CNT,
	PERF_ADJ_TOTAL_PY_CNT,
	PERF_ADJ_TOTAL_PY_BYTD_CNT,
	PERF_ADJ_TOTAL_PY_SWDAY_CNT,
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT,
	PERF_ADJ_TOTAL_QTY,
	PERF_ADJ_TOTAL_BYTD_QTY,
	PERF_ADJ_TOTAL_PY_QTY,
	PERF_ADJ_TOTAL_PY_BYTD_QTY,
	PERF_ADJ_TOTAL_PY_SWDAY_QTY,
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD
) as
SELECT
      f_tsdp.bus_dt
    , f_tsdp.store_sid
    , f_tsdp.prod_sid
    , f_tsdp.sales_variant_sid
    , f_tsdp.country_org_sid
    , f_tsdp.country_org_cd
    , Coalesce(f_tsdp.sales_cnt, 0) + Coalesce(f_tsdp.return_cnt, 0) AS total_cnt
    , Coalesce(f_tsdp.sales_qty, 0) + Coalesce(f_tsdp.return_qty, 0) AS total_qty
    , f_tsdp.uom_cd
    , Coalesce(f_tsdp.cash_register_sales_net_val, 0) + Coalesce(f_tsdp.cash_register_return_net_val, 0) AS turnover_net_val
    , Coalesce(f_tsdp.cash_register_sales_gross_val, 0) + Coalesce(f_tsdp.cash_register_return_gross_val, 0) AS turnover_gross_val
    , f_tsdp.curr_cd
    , SUM(Coalesce(f_tsdp.cash_register_sales_net_val, 0) + Coalesce(f_tsdp.cash_register_return_net_val, 0)) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                     AS turnover_bytd_net_val
    , f_tsdp_py.turnover_net_val            AS turnover_py_net_val
    , f_tsdp_py.turnover_bytd_net_val       AS turnover_py_bytd_net_val
    , f_tsdp_py_swday.turnover_net_val      AS turnover_py_swday_net_val
    , f_tsdp_py_swday.turnover_bytd_net_val AS turnover_py_swday_bytd_net_val
    , f_tsdp.cash_register_sales_net_val    AS sales_net_val
    , SUM(f_tsdp.cash_register_sales_net_val) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                  AS sales_bytd_net_val
    , f_tsdp_py.sales_net_val            AS sales_py_net_val
    , f_tsdp_py.sales_bytd_net_val       AS sales_py_bytd_net_val
    , f_tsdp_py_swday.sales_net_val      AS sales_py_swday_net_val
    , f_tsdp_py_swday.sales_bytd_net_val AS sales_py_swday_bytd_net_val
    , f_tsdp.cash_register_return_net_val AS return_net_val
    , SUM(f_tsdp.cash_register_return_net_val) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                     AS return_bytd_net_val
    , f_tsdp_py.return_net_val            AS return_py_net_val
    , f_tsdp_py.return_bytd_net_val       AS return_py_bytd_net_val
    , f_tsdp_py_swday.return_net_val      AS return_py_swday_net_val
    , f_tsdp_py_swday.return_bytd_net_val AS return_py_swday_bytd_net_val
    , f_tsdp.sales_cnt
    , SUM(f_tsdp.sales_cnt) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                            AS sales_bytd_cnt
    , f_tsdp_py.sales_cnt            AS sales_py_cnt
    , f_tsdp_py.sales_bytd_cnt       AS sales_py_bytd_cnt
    , f_tsdp_py_swday.sales_cnt      AS sales_py_swday_cnt
    , f_tsdp_py_swday.sales_bytd_cnt AS sales_py_swday_bytd_cnt
    , f_tsdp.sales_qty
    , SUM(f_tsdp.sales_qty) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                            AS sales_bytd_qty
    , f_tsdp_py.sales_qty            AS sales_py_qty
    , f_tsdp_py.sales_bytd_qty       AS sales_py_bytd_qty
    , f_tsdp_py_swday.sales_qty      AS sales_py_swday_qty
    , f_tsdp_py_swday.sales_bytd_qty AS sales_py_swday_bytd_qty
    , f_tsdp.return_cnt
    , SUM(f_tsdp.return_cnt) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                            AS return_bytd_cnt
    , f_tsdp_py.return_cnt            AS return_py_cnt
    , f_tsdp_py.return_bytd_cnt       AS return_py_bytd_cnt
    , f_tsdp_py_swday.return_cnt      AS return_py_swday_cnt
    , f_tsdp_py_swday.return_bytd_cnt AS return_py_swday_bytd_cnt
    , f_tsdp.return_qty
    , SUM(f_tsdp.return_qty) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                             AS return_bytd_qty
    , f_tsdp_py.return_qty            AS return_py_qty
    , f_tsdp_py.return_bytd_qty       AS return_py_bytd_qty
    , f_tsdp_py_swday.return_qty      AS return_py_swday_qty
    , f_tsdp_py_swday.return_bytd_qty AS return_py_swday_bytd_qty
    , Coalesce(f_tsdp.perf_adj_sales_cnt, 0) + Coalesce(f_tsdp.perf_adj_return_cnt, 0) AS perf_adj_total_cnt 
    , SUM(Coalesce(f_tsdp.perf_adj_sales_cnt, 0) + Coalesce(f_tsdp.perf_adj_return_cnt, 0)) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                            AS perf_adj_total_bytd_cnt
    , f_tsdp_py.perf_adj_total_cnt            AS perf_adj_total_py_cnt
    , f_tsdp_py.perf_adj_total_bytd_cnt       AS perf_adj_total_py_bytd_cnt
    , f_tsdp_py_swday.perf_adj_total_cnt      AS perf_adj_total_py_swday_cnt
    , f_tsdp_py_swday.perf_adj_total_bytd_cnt AS perf_adj_total_py_swday_bytd_cnt
    , Coalesce(f_tsdp.perf_adj_sales_qty, 0) + Coalesce(f_tsdp.perf_adj_return_qty, 0) AS perf_adj_total_qty
    , SUM(Coalesce(f_tsdp.perf_adj_sales_qty, 0) + Coalesce(f_tsdp.perf_adj_return_qty, 0)) OVER
      ( PARTITION BY
          d_cd.bus_year, f_tsdp.store_sid, f_tsdp.prod_sid, f_tsdp.sales_variant_sid, f_tsdp.country_org_cd, f_tsdp.uom_cd, f_tsdp.curr_cd
        ORDER BY
          f_tsdp.bus_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )                                            AS perf_adj_total_bytd_qty
    , f_tsdp_py.perf_adj_total_qty            AS perf_adj_total_py_qty
    , f_tsdp_py.perf_adj_total_bytd_qty       AS perf_adj_total_py_bytd_qty
    , f_tsdp_py_swday.perf_adj_total_qty      AS perf_adj_total_py_swday_qty
    , f_tsdp_py_swday.perf_adj_total_bytd_qty AS perf_adj_total_py_swday_bytd_qty
    , f_tsdp.dwh_created_tmsp
    , f_tsdp.dwh_updated_tmsp
    , f_tsdp.dwh_load_id
    , f_tsdp.dwh_node_cd
FROM  core_dim.t_fact_retail_by_store_day_product_1 AS f_tsdp
INNER JOIN
      core_dim.t_dim_calendar_date_1 AS d_cd
  ON  d_cd.cal_dt = f_tsdp.bus_dt
LEFT OUTER JOIN
    ( SELECT
            sub1.bus_dt, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid
          , sub1.country_org_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
          , Coalesce(sub1.cash_register_sales_net_val, 0) + Coalesce(sub1.cash_register_return_net_val, 0) AS turnover_net_val
          , SUM(Coalesce(sub1.cash_register_sales_net_val, 0) + Coalesce(sub1.cash_register_return_net_val, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS turnover_bytd_net_val
          , sub1.cash_register_sales_net_val AS sales_net_val
          , SUM(sub1.cash_register_sales_net_val) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_net_val
          , sub1.cash_register_return_net_val AS return_net_val
          , SUM(sub1.cash_register_return_net_val) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_net_val
          , sub1.sales_cnt
          , SUM(sub1.sales_cnt) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_cnt
          , sub1.sales_qty
          , SUM(sub1.sales_qty) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_qty
          , sub1.return_cnt
          , SUM(sub1.return_cnt) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_cnt
          , sub1.return_qty
          , SUM(sub1.return_qty) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_qty
          , Coalesce(sub1.perf_adj_sales_cnt, 0) + Coalesce(sub1.perf_adj_return_cnt, 0) AS perf_adj_total_cnt
          , SUM(Coalesce(sub1.perf_adj_sales_cnt, 0) + Coalesce(sub1.perf_adj_return_cnt, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS perf_adj_total_bytd_cnt
          , Coalesce(sub1.perf_adj_sales_qty, 0) + Coalesce(sub1.perf_adj_return_qty, 0) AS perf_adj_total_qty
          , SUM(Coalesce(sub1.perf_adj_sales_qty, 0) + Coalesce(sub1.perf_adj_return_qty, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS perf_adj_total_bytd_qty
      FROM  core_dim.t_fact_retail_by_store_day_product_1 AS sub1
      INNER JOIN
            core_dim.t_dim_calendar_date_1 AS sub2
        ON  sub2.cal_dt = sub1.bus_dt
    ) AS f_tsdp_py
  ON  f_tsdp_py.bus_dt            = d_cd.prev_1y_cal_dt
  AND f_tsdp_py.store_sid         = f_tsdp.store_sid
  AND f_tsdp_py.prod_sid          = f_tsdp.prod_sid
  AND f_tsdp_py.sales_variant_sid = f_tsdp.sales_variant_sid
  AND f_tsdp_py.country_org_cd    = f_tsdp.country_org_cd
  AND f_tsdp_py.uom_cd            = f_tsdp.uom_cd
  AND f_tsdp_py.curr_cd           = f_tsdp.curr_cd
LEFT OUTER JOIN
    ( SELECT
            sub1.bus_dt, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid
          , sub1.country_org_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
          , Coalesce(sub1.cash_register_sales_net_val, 0) + Coalesce(sub1.cash_register_return_net_val, 0) AS turnover_net_val
          , SUM(Coalesce(sub1.cash_register_sales_net_val, 0) + Coalesce(sub1.cash_register_return_net_val, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS turnover_bytd_net_val
          , sub1.cash_register_sales_net_val AS sales_net_val
          , SUM(sub1.cash_register_sales_net_val) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_net_val
          , sub1.cash_register_return_net_val AS return_net_val
          , SUM(sub1.cash_register_return_net_val) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_net_val
          , sub1.sales_cnt
          , SUM(sub1.sales_cnt) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_cnt
          , sub1.sales_qty
          , SUM(sub1.sales_qty) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sales_bytd_qty
          , sub1.return_cnt
          , SUM(sub1.return_cnt) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_cnt
          , sub1.return_qty
          , SUM(sub1.return_qty) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS return_bytd_qty
          , Coalesce(sub1.perf_adj_sales_cnt, 0) + Coalesce(sub1.perf_adj_return_cnt, 0) AS perf_adj_total_cnt
          , SUM(Coalesce(sub1.perf_adj_sales_cnt, 0) + Coalesce(sub1.perf_adj_return_cnt, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS perf_adj_total_bytd_cnt
          , Coalesce(sub1.perf_adj_sales_qty, 0) + Coalesce(sub1.perf_adj_return_qty, 0) AS perf_adj_total_qty
          , SUM(Coalesce(sub1.perf_adj_sales_qty, 0) + Coalesce(sub1.perf_adj_return_qty, 0)) OVER
            ( PARTITION BY
                sub2.bus_year, sub1.store_sid, sub1.prod_sid, sub1.sales_variant_sid, sub1.country_org_cd, sub1.uom_cd, sub1.curr_cd
              ORDER BY
                sub1.bus_dt
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS perf_adj_total_bytd_qty
      FROM  core_dim.t_fact_retail_by_store_day_product_1 AS sub1
      INNER JOIN
            core_dim.t_dim_calendar_date_1 AS sub2
        ON  sub2.cal_dt = sub1.bus_dt
    ) AS f_tsdp_py_swday
  ON  f_tsdp_py_swday.bus_dt            = d_cd.prev_1y_swday_cal_dt
  AND f_tsdp_py_swday.store_sid         = f_tsdp.store_sid
  AND f_tsdp_py_swday.prod_sid          = f_tsdp.prod_sid
  AND f_tsdp_py_swday.sales_variant_sid = f_tsdp.sales_variant_sid
  AND f_tsdp_py_swday.country_org_cd    = f_tsdp.country_org_cd
  AND f_tsdp_py_swday.uom_cd            = f_tsdp.uom_cd
  AND f_tsdp_py_swday.curr_cd           = f_tsdp.curr_cd
;