create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_DAY_PRODUCT_2(
	CAL_DT COMMENT 'The business date to which the measures are related.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for the sales_2 variant of a product.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization. This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
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
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	SALES_VARIANT_SALES_CNT,
	SALES_VARIANT_SALES_BYTD_CNT,
	SALES_VARIANT_SALES_PY_CNT,
	SALES_VARIANT_SALES_PY_BYTD_CNT,
	SALES_VARIANT_SALES_PY_SWDAY_CNT,
	SALES_VARIANT_SALES_PY_SWDAY_BYTD_CNT,
	SALES_VARIANT_SALES_QTY,
	SALES_VARIANT_SALES_BYTD_QTY,
	SALES_VARIANT_SALES_PY_QTY,
	SALES_VARIANT_SALES_PY_BYTD_QTY,
	SALES_VARIANT_SALES_PY_SWDAY_QTY,
	SALES_VARIANT_SALES_PY_SWDAY_BYTD_QTY,
	SALES_VARIANT_RETURN_CNT,
	SALES_VARIANT_RETURN_BYTD_CNT,
	SALES_VARIANT_RETURN_PY_CNT,
	SALES_VARIANT_RETURN_PY_BYTD_CNT,
	SALES_VARIANT_RETURN_PY_SWDAY_CNT,
	SALES_VARIANT_RETURN_PY_SWDAY_BYTD_CNT,
	SALES_VARIANT_RETURN_QTY,
	SALES_VARIANT_RETURN_BYTD_QTY,
	SALES_VARIANT_RETURN_PY_QTY,
	SALES_VARIANT_RETURN_PY_BYTD_QTY,
	SALES_VARIANT_RETURN_PY_SWDAY_QTY,
	SALES_VARIANT_RETURN_PY_SWDAY_BYTD_QTY,
	SALES_VARIANT_PERF_TOTAL_CNT,
	SALES_VARIANT_PERF_TOTAL_BYTD_CNT,
	SALES_VARIANT_PERF_TOTAL_PY_CNT,
	SALES_VARIANT_PERF_TOTAL_PY_BYTD_CNT,
	SALES_VARIANT_PERF_TOTAL_PY_SWDAY_CNT,
	SALES_VARIANT_PERF_TOTAL_PY_SWDAY_BYTD_CNT,
	SALES_VARIANT_PERF_TOTAL_QTY,
	SALES_VARIANT_PERF_TOTAL_BYTD_QTY,
	SALES_VARIANT_PERF_TOTAL_PY_QTY,
	SALES_VARIANT_PERF_TOTAL_PY_BYTD_QTY,
	SALES_VARIANT_PERF_TOTAL_PY_SWDAY_QTY,
	SALES_VARIANT_PERF_TOTAL_PY_SWDAY_BYTD_QTY,
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='An aggregate fact holding gross and net turnover per day, product and store. Turnover amounts are taken from the cash register.'
 as
SELECT
  main.bus_dt AS cal_dt
, main.store_sid AS store_sid
, main.prod_sid AS prod_sid
, main.sales_variant_sid AS sales_variant_sid
, main.country_org_sid AS country_org_sid
, main.country_org_cd AS country_org_cd
, main.turnover_net_val / fer.exchange_rate AS turnover_net_val
, main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val
, main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val
, main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val
, main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val
, main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
, main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val
, main.sales_net_val / fer.exchange_rate AS sales_net_val
, main.sales_bytd_net_val / fer.exchange_rate AS sales_bytd_net_val
, main.sales_py_net_val / fer.exchange_rate AS sales_py_net_val
, main.sales_py_bytd_net_val / fer.exchange_rate AS sales_py_bytd_net_val
, main.sales_py_swday_net_val / fer.exchange_rate AS sales_py_swday_net_val
, main.sales_py_swday_bytd_net_val / fer.exchange_rate AS sales_py_swday_bytd_net_val
, main.return_net_val / fer.exchange_rate AS return_net_val
, main.return_bytd_net_val / fer.exchange_rate AS return_bytd_net_val
, main.return_py_net_val / fer.exchange_rate AS return_py_net_val
, main.return_py_bytd_net_val / fer.exchange_rate AS return_py_bytd_net_val
, main.return_py_swday_net_val / fer.exchange_rate AS return_py_swday_net_val
, main.return_py_swday_bytd_net_val / fer.exchange_rate AS return_py_swday_bytd_net_val
, fer.src_curr_cd AS curr_cd
, DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
, DECODE(fer.src_curr_cd,fer.TGT_CURR_CD,1,0) AS curr_local_fg
, main.sales_variant_sales_cnt AS sales_variant_sales_cnt
, main.sales_variant_sales_bytd_cnt AS sales_variant_sales_bytd_cnt
, main.sales_variant_sales_py_cnt AS sales_variant_sales_py_cnt
, main.sales_variant_sales_py_bytd_cnt AS sales_variant_sales_py_bytd_cnt
, main.sales_variant_sales_py_swday_cnt AS sales_variant_sales_py_swday_cnt
, main.sales_variant_sales_py_swday_bytd_cnt AS sales_variant_sales_py_swday_bytd_cnt
, main.sales_variant_sales_qty AS sales_variant_sales_qty
, main.sales_variant_sales_bytd_qty AS sales_variant_sales_bytd_qty
, main.sales_variant_sales_py_qty AS sales_variant_sales_py_qty
, main.sales_variant_sales_py_bytd_qty AS sales_variant_sales_py_bytd_qty
, main.sales_variant_sales_py_swday_qty AS sales_variant_sales_py_swday_qty
, main.sales_variant_sales_py_swday_bytd_qty AS sales_variant_sales_py_swday_bytd_qty
, main.sales_variant_return_cnt AS sales_variant_return_cnt
, main.sales_variant_return_bytd_cnt AS sales_variant_return_bytd_cnt
, main.sales_variant_return_py_cnt AS sales_variant_return_py_cnt
, main.sales_variant_return_py_bytd_cnt AS sales_variant_return_py_bytd_cnt
, main.sales_variant_return_py_swday_cnt AS sales_variant_return_py_swday_cnt
, main.sales_variant_return_py_swday_bytd_cnt AS sales_variant_return_py_swday_bytd_cnt
, main.sales_variant_return_qty AS sales_variant_return_qty
, main.sales_variant_return_bytd_qty AS sales_variant_return_bytd_qty
, main.sales_variant_return_py_qty AS sales_variant_return_py_qty
, main.sales_variant_return_py_bytd_qty AS sales_variant_return_py_bytd_qty
, main.sales_variant_return_py_swday_qty AS sales_variant_return_py_swday_qty
, main.sales_variant_return_py_swday_bytd_qty AS sales_variant_return_py_swday_bytd_qty
, main.sales_variant_perf_total_cnt AS sales_variant_perf_total_cnt
, main.sales_variant_perf_total_bytd_cnt AS sales_variant_perf_total_bytd_cnt
, main.sales_variant_perf_total_py_cnt AS sales_variant_perf_total_py_cnt
, main.sales_variant_perf_total_py_bytd_cnt AS sales_variant_perf_total_py_bytd_cnt
, main.sales_variant_perf_total_py_swday_cnt AS sales_variant_perf_total_py_swday_cnt
, main.sales_variant_perf_total_py_swday_bytd_cnt AS sales_variant_perf_total_py_swday_bytd_cnt
, main.sales_variant_perf_total_qty AS sales_variant_perf_total_qty
, main.sales_variant_perf_total_bytd_qty AS sales_variant_perf_total_bytd_qty
, main.sales_variant_perf_total_py_qty AS sales_variant_perf_total_py_qty
, main.sales_variant_perf_total_py_bytd_qty AS sales_variant_perf_total_py_bytd_qty
, main.sales_variant_perf_total_py_swday_qty AS sales_variant_perf_total_py_swday_qty
, main.sales_variant_perf_total_py_swday_bytd_qty AS sales_variant_perf_total_py_swday_bytd_qty
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.V_FACT_TURNOVER_BY_STORE_DAY_PRODUCT_2 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_2 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE;