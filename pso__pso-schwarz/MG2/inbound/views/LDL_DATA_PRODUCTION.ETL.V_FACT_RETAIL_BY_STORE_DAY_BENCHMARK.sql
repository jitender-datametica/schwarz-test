create or replace view LDL_DATA_PRODUCTION.ETL.V_FACT_RETAIL_BY_STORE_DAY_BENCHMARK(
	BUS_DT,
	INT_ORG_SID,
	BENCHMARKING_TYPE_ID,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	TURNOVER_NET_VAL,
	TURNOVER_BYTD_NET_VAL,
	TURNOVER_PY_NET_VAL,
	TURNOVER_PY_BYTD_NET_VAL,
	TURNOVER_PY_SWDAY_NET_VAL,
	TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	CASH_REGISTER_TURNOVER_NET_VAL,
	EOD_TURNOVER_NET_VAL,
	BOOKED_TURNOVER_NET_VAL,
	PLAN_TURNOVER_NET_VAL,
	PLAN_TURNOVER_BYTD_NET_VAL,
	PLAN_TURNOVER_PY_NET_VAL,
	PLAN_TURNOVER_PY_BYTD_NET_VAL,
	PLAN_TURNOVER_PY_SWDAY_NET_VAL,
	PLAN_TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	TURNOVER_GROSS_VAL,
	TURNOVER_BYTD_GROSS_VAL,
	TURNOVER_PY_GROSS_VAL,
	TURNOVER_PY_BYTD_GROSS_VAL,
	TURNOVER_PY_SWDAY_GROSS_VAL,
	TURNOVER_PY_SWDAY_BYTD_GROSS_VAL,
	CASH_REGISTER_TURNOVER_GROSS_VAL,
	EOD_TURNOVER_GROSS_VAL,
	CURR_CD,
	RECEIPT_CNT,
	RECEIPT_BYTD_CNT,
	RECEIPT_PY_CNT,
	RECEIPT_PY_BYTD_CNT,
	RECEIPT_PY_SWDAY_CNT,
	RECEIPT_PY_SWDAY_BYTD_CNT,
	CASH_REGISTER_RECEIPT_CNT,
	EOD_RECEIPT_CNT,
	BOOKED_RECEIPT_CNT,
	PLAN_RECEIPT_CNT,
	PLAN_RECEIPT_BYTD_CNT,
	PLAN_RECEIPT_PY_CNT,
	PLAN_RECEIPT_PY_BYTD_CNT,
	PLAN_RECEIPT_PY_SWDAY_CNT,
	PLAN_RECEIPT_PY_SWDAY_BYTD_CNT,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD
) as
SELECT
      main.bus_dt AS bus_dt
    , main.int_org_sid AS int_org_sid
    , 1::NUMBER(38,0) AS benchmarking_type_id
    , main.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , main.turnover_net_val  AS turnover_net_val
    , main.turnover_bytd_net_val  AS turnover_bytd_net_val
    , main.turnover_py_net_val  AS turnover_py_net_val
    , main.turnover_py_bytd_net_val  AS turnover_py_bytd_net_val
    , main.turnover_py_swday_net_val  AS turnover_py_swday_net_val
    , main.turnover_py_swday_bytd_net_val  AS turnover_py_swday_bytd_net_val
    , main.cash_register_sales_net_val + main.cash_register_return_net_val   AS cash_register_turnover_net_val
    , main.eod_turnover_net_val  AS eod_turnover_net_val
    , main.booked_turnover_net_val  AS booked_turnover_net_val
    , main.plan_turnover_net_val  AS plan_turnover_net_val
    , main.plan_turnover_bytd_net_val  AS plan_turnover_bytd_net_val
    , main.plan_turnover_py_net_val  AS plan_turnover_py_net_val
    , main.plan_turnover_py_bytd_net_val  AS plan_turnover_py_bytd_net_val
    , main.plan_turnover_py_swday_net_val  AS plan_turnover_py_swday_net_val
    , main.plan_turnover_py_swday_bytd_net_val  AS plan_turnover_py_swday_bytd_net_val
    , main.turnover_gross_val  AS turnover_gross_val
    , main.turnover_bytd_gross_val  AS turnover_bytd_gross_val
    , main.turnover_py_gross_val  AS turnover_py_gross_val
    , main.turnover_py_bytd_gross_val  AS turnover_py_bytd_gross_val
    , main.turnover_py_swday_gross_val  AS turnover_py_swday_gross_val
    , main.turnover_py_swday_bytd_gross_val  AS turnover_py_swday_bytd_gross_val
    , main.cash_register_sales_gross_val + main.cash_register_return_gross_val AS cash_register_turnover_gross_val
    , main.eod_turnover_gross_val  AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , main.receipt_cnt AS receipt_cnt
    , main.receipt_bytd_cnt AS receipt_bytd_cnt
    , main.receipt_py_cnt AS receipt_py_cnt
    , main.receipt_py_bytd_cnt AS receipt_py_bytd_cnt
    , main.receipt_py_swday_cnt AS receipt_py_swday_cnt
    , main.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt
    , main.cash_register_receipt_cnt AS cash_register_receipt_cnt
    , main.eod_receipt_cnt AS eod_receipt_cnt
    , main.booked_receipt_cnt AS booked_receipt_cnt
    , main.plan_receipt_cnt AS plan_receipt_cnt
    , main.plan_receipt_bytd_cnt AS plan_receipt_bytd_cnt
    , main.plan_receipt_py_cnt AS plan_receipt_py_cnt
    , main.plan_receipt_py_bytd_cnt AS plan_receipt_py_bytd_cnt
    , main.plan_receipt_py_swday_cnt AS plan_receipt_py_swday_cnt
    , main.plan_receipt_py_swday_bytd_cnt AS plan_receipt_py_swday_bytd_cnt
    , main.dwh_created_tmsp AS dwh_created_tmsp
    , main.dwh_updated_tmsp AS dwh_updated_tmsp
    , main.dwh_load_id AS dwh_load_id
    , main.dwh_node_cd AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main

UNION ALL

SELECT
      main.bus_dt AS bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_mgr_district_sid
      ) AS int_org_sid
    , 2::NUMBER(38,0) AS benchmarking_type_id
    , org.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , SUM(main.turnover_net_val) AS turnover_net_val
    , SUM(main.turnover_bytd_net_val) AS turnover_bytd_net_val
    , SUM(main.turnover_py_net_val) AS turnover_py_net_val
    , SUM(main.turnover_py_bytd_net_val) AS turnover_py_bytd_net_val
    , SUM(main.turnover_py_swday_net_val) AS turnover_py_swday_net_val
    , SUM(main.turnover_py_swday_bytd_net_val) AS turnover_py_swday_bytd_net_val
    , SUM (main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
    , SUM(main.eod_turnover_net_val) AS eod_turnover_net_val
    , SUM(main.booked_turnover_net_val) AS booked_turnover_net_val
    , SUM(main.plan_turnover_net_val) AS plan_turnover_net_val
    , SUM(main.plan_turnover_bytd_net_val) AS plan_turnover_bytd_net_val
    , SUM(main.plan_turnover_py_net_val) AS plan_turnover_py_net_val
    , SUM(main.plan_turnover_py_bytd_net_val) AS plan_turnover_py_bytd_net_val
    , SUM(main.plan_turnover_py_swday_net_val) AS plan_turnover_py_swday_net_val
    , SUM(main.plan_turnover_py_swday_bytd_net_val) AS plan_turnover_py_swday_bytd_net_val
    , SUM(main.turnover_gross_val) AS turnover_gross_val
    , SUM(main.turnover_bytd_gross_val) AS turnover_bytd_gross_val
    , SUM(main.turnover_py_gross_val) AS turnover_py_gross_val
    , SUM(main.turnover_py_bytd_gross_val) AS turnover_py_bytd_gross_val
    , SUM(main.turnover_py_swday_gross_val) AS turnover_py_swday_gross_val
    , SUM(main.turnover_py_swday_bytd_gross_val) AS turnover_py_swday_bytd_gross_val
    , SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
    , SUM(main.eod_turnover_gross_val) AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , SUM(main.receipt_cnt) AS receipt_cnt
    , SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
    , SUM(main.receipt_py_cnt) AS receipt_py_cnt
    , SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
    , SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
    , SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
    , SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
    , SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
    , SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
    , SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
    , SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
    , SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
    , SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
    , SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
    , SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
    , MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
    , MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
    , MAX(main.dwh_load_id) AS dwh_load_id
    , MAX(main.dwh_node_cd) AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main
INNER JOIN
      ( SELECT
              org_store.int_org_sid
            , org_store.is_country_org_fg
            , org_store.sales_mgr_district_sid
            , org_sales.int_org_type_cd
        FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_store
        INNER JOIN
              CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_sales
          ON  org_sales.int_org_sid = org_store.sales_mgr_district_sid
        WHERE org_store.dwh_valid_fg = true
          AND org_sales.dwh_valid_fg = true
      ) org
  ON  org.int_org_sid = main.int_org_sid
GROUP BY
      main.bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_mgr_district_sid
      )
    , benchmarking_type_id
    , org.int_org_type_cd
    , main.country_org_cd
    , main.curr_cd

UNION ALL

SELECT
      main.bus_dt AS bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.acct_mgr_district_sid
      ) AS int_org_sid
    , 3::NUMBER(38,0) AS benchmarking_type_id
    , org.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , SUM(main.turnover_net_val ) AS turnover_net_val
    , SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
    , SUM(main.turnover_py_net_val ) AS turnover_py_net_val
    , SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
    , SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
    , SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
    , SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
    , SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
    , SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
    , SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
    , SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
    , SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
    , SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
    , SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
    , SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
    , SUM(main.turnover_gross_val ) AS turnover_gross_val
    , SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
    , SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
    , SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
    , SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
    , SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
    , SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
    , SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , SUM(main.receipt_cnt) AS receipt_cnt
    , SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
    , SUM(main.receipt_py_cnt) AS receipt_py_cnt
    , SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
    , SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
    , SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
    , SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
    , SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
    , SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
    , SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
    , SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
    , SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
    , SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
    , SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
    , SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
    , MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
    , MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
    , MAX(main.dwh_load_id) AS dwh_load_id
    , MAX(main.dwh_node_cd) AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main
INNER JOIN
      ( SELECT
              org_store.int_org_sid
            , org_store.is_country_org_fg
            , org_store.acct_mgr_district_sid
            , org_acct.int_org_type_cd
        FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_store
        INNER JOIN
              CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_acct
          ON  org_acct.int_org_sid = org_store.acct_mgr_district_sid
        WHERE org_store.dwh_valid_fg = true
          AND org_acct.dwh_valid_fg = true
      ) org
  ON  org.int_org_sid = main.int_org_sid
GROUP BY
      main.bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.acct_mgr_district_sid
      )
    , benchmarking_type_id
    , org.int_org_type_cd
    , main.country_org_cd
    , main.curr_cd

UNION ALL

SELECT
      main.bus_dt AS bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_company_sid
      ) AS int_org_sid
    , 4::NUMBER(38,0) AS benchmarking_type_id
    , org.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , SUM(main.turnover_net_val ) AS turnover_net_val
    , SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
    , SUM(main.turnover_py_net_val ) AS turnover_py_net_val
    , SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
    , SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
    , SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
    , SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
    , SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
    , SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
    , SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
    , SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
    , SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
    , SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
    , SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
    , SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
    , SUM(main.turnover_gross_val ) AS turnover_gross_val
    , SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
    , SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
    , SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
    , SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
    , SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
    , SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
    , SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , SUM(main.receipt_cnt) AS receipt_cnt
    , SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
    , SUM(main.receipt_py_cnt) AS receipt_py_cnt
    , SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
    , SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
    , SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
    , SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
    , SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
    , SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
    , SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
    , SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
    , SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
    , SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
    , SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
    , SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
    , MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
    , MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
    , MAX(main.dwh_load_id) AS dwh_load_id
    , MAX(main.dwh_node_cd) AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main
INNER JOIN
      ( SELECT
              org_store.int_org_sid
            , org_store.is_country_org_fg
            , org_store.sales_company_sid
            , org_cmpy.int_org_type_cd
        FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_store
        INNER JOIN
              CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_cmpy
          ON  org_cmpy.int_org_sid = org_store.sales_company_sid
        WHERE org_store.dwh_valid_fg = true
          AND org_cmpy.dwh_valid_fg = true
      ) org
  ON  org.int_org_sid = main.int_org_sid
GROUP BY
      main.bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_company_sid
      )
    , benchmarking_type_id
    , org.int_org_type_cd
    , main.country_org_cd
    , main.curr_cd

UNION ALL

SELECT
      main.bus_dt AS bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_region_sid
      ) AS int_org_sid
    , 5::NUMBER(38,0) AS benchmarking_type_id
    , org.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , SUM(main.turnover_net_val ) AS turnover_net_val
    , SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
    , SUM(main.turnover_py_net_val ) AS turnover_py_net_val
    , SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
    , SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
    , SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
    , SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
    , SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
    , SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
    , SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
    , SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
    , SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
    , SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
    , SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
    , SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
    , SUM(main.turnover_gross_val ) AS turnover_gross_val
    , SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
    , SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
    , SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
    , SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
    , SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
    , SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
    , SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , SUM(main.receipt_cnt) AS receipt_cnt
    , SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
    , SUM(main.receipt_py_cnt) AS receipt_py_cnt
    , SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
    , SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
    , SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
    , SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
    , SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
    , SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
    , SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
    , SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
    , SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
    , SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
    , SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
    , SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
    , MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
    , MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
    , MAX(main.dwh_load_id) AS dwh_load_id
    , MAX(main.dwh_node_cd) AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main
INNER JOIN
      ( SELECT
              org_store.int_org_sid
            , org_store.is_country_org_fg
            , org_store.sales_region_sid
            , org_regio.int_org_type_cd
        FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_store
        INNER JOIN
              CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_regio
          ON  org_regio.int_org_sid = org_store.sales_region_sid
        WHERE org_store.dwh_valid_fg = true
          AND org_regio.dwh_valid_fg = true
      ) org
  ON  org.int_org_sid = main.int_org_sid
GROUP BY
      main.bus_dt
    , DECODE( org.is_country_org_fg
            , true, org.int_org_sid
            , org.sales_region_sid
      )
    , benchmarking_type_id
    , org.int_org_type_cd
    , main.country_org_cd
    , main.curr_cd

UNION ALL

SELECT
      main.bus_dt AS bus_dt
    , org.country_org_sid AS int_org_sid
    , 6::NUMBER(38,0) AS benchmarking_type_id
    , org.int_org_type_cd AS int_org_type_cd
    , main.country_org_cd AS country_org_cd
    , SUM(main.turnover_net_val ) AS turnover_net_val
    , SUM(main.turnover_bytd_net_val ) AS turnover_bytd_net_val
    , SUM(main.turnover_py_net_val ) AS turnover_py_net_val
    , SUM(main.turnover_py_bytd_net_val ) AS turnover_py_bytd_net_val
    , SUM(main.turnover_py_swday_net_val ) AS turnover_py_swday_net_val
    , SUM(main.turnover_py_swday_bytd_net_val ) AS turnover_py_swday_bytd_net_val
    , SUM(main.cash_register_sales_net_val + main.cash_register_return_net_val) AS cash_register_turnover_net_val
    , SUM(main.eod_turnover_net_val ) AS eod_turnover_net_val
    , SUM(main.booked_turnover_net_val ) AS booked_turnover_net_val
    , SUM(main.plan_turnover_net_val ) AS plan_turnover_net_val
    , SUM(main.plan_turnover_bytd_net_val ) AS plan_turnover_bytd_net_val
    , SUM(main.plan_turnover_py_net_val ) AS plan_turnover_py_net_val
    , SUM(main.plan_turnover_py_bytd_net_val ) AS plan_turnover_py_bytd_net_val
    , SUM(main.plan_turnover_py_swday_net_val ) AS plan_turnover_py_swday_net_val
    , SUM(main.plan_turnover_py_swday_bytd_net_val ) AS plan_turnover_py_swday_bytd_net_val
    , SUM(main.turnover_gross_val ) AS turnover_gross_val
    , SUM(main.turnover_bytd_gross_val ) AS turnover_bytd_gross_val
    , SUM(main.turnover_py_gross_val ) AS turnover_py_gross_val
    , SUM(main.turnover_py_bytd_gross_val ) AS turnover_py_bytd_gross_val
    , SUM(main.turnover_py_swday_gross_val ) AS turnover_py_swday_gross_val
    , SUM(main.turnover_py_swday_bytd_gross_val ) AS turnover_py_swday_bytd_gross_val
    , SUM(main.cash_register_sales_gross_val + main.cash_register_return_gross_val) AS cash_register_turnover_gross_val
    , SUM(main.eod_turnover_gross_val ) AS eod_turnover_gross_val
    , main.curr_cd AS curr_cd
    , SUM(main.receipt_cnt) AS receipt_cnt
    , SUM(main.receipt_bytd_cnt) AS receipt_bytd_cnt
    , SUM(main.receipt_py_cnt) AS receipt_py_cnt
    , SUM(main.receipt_py_bytd_cnt) AS receipt_py_bytd_cnt
    , SUM(main.receipt_py_swday_cnt) AS receipt_py_swday_cnt
    , SUM(main.receipt_py_swday_bytd_cnt) AS receipt_py_swday_bytd_cnt
    , SUM(main.cash_register_receipt_cnt) AS cash_register_receipt_cnt
    , SUM(main.eod_receipt_cnt) AS eod_receipt_cnt
    , SUM(main.booked_receipt_cnt) AS booked_receipt_cnt
    , SUM(main.plan_receipt_cnt) AS plan_receipt_cnt
    , SUM(main.plan_receipt_bytd_cnt) AS plan_receipt_bytd_cnt
    , SUM(main.plan_receipt_py_cnt) AS plan_receipt_py_cnt
    , SUM(main.plan_receipt_py_bytd_cnt) AS plan_receipt_py_bytd_cnt
    , SUM(main.plan_receipt_py_swday_cnt) AS plan_receipt_py_swday_cnt
    , SUM(main.plan_receipt_py_swday_bytd_cnt) AS plan_receipt_py_swday_bytd_cnt
    , MAX(main.dwh_created_tmsp) AS dwh_created_tmsp
    , MAX(main.dwh_updated_tmsp) AS dwh_updated_tmsp
    , MAX(main.dwh_load_id) AS dwh_load_id
    , MAX(main.dwh_node_cd) AS dwh_node_cd
FROM  CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY main
INNER JOIN
      ( SELECT
              org_store.int_org_sid
            , org_store.is_country_org_fg
            , org_store.country_org_sid
            , org_cntry.int_org_type_cd
        FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_store
        INNER JOIN
              CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org_cntry
          ON  org_cntry.int_org_sid = org_store.country_org_sid
        WHERE org_store.dwh_valid_fg = true
          AND org_cntry.dwh_valid_fg = true
      ) org
  ON  org.int_org_sid = main.int_org_sid
GROUP BY
      main.bus_dt
    , org.country_org_sid
    , benchmarking_type_id
    , org.int_org_type_cd
    , main.country_org_cd
    , main.curr_cd;