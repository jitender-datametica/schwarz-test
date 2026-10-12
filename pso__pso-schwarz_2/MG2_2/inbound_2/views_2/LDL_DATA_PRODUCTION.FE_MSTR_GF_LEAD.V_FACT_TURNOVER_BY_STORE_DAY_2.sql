create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_DAY_2(
	CAL_DT COMMENT 'The business date to which the measures are related.',
	STORE_SID COMMENT 'Th,e unique identifier (surrogate key) for a store.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for that store on the given day according to the cash register.',
	EOD_TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.',
	BOOKED_TURNOVER_NET_VAL COMMENT 'The net turnover which has been booked to the store by financial accounting.',
	PLAN_TURNOVER_NET_VAL COMMENT 'The net turnover which has been planned for that store and that day.',
	PLAN_TURNOVER_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which has been planned for that store up to the given day.',
	PLAN_TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was planned for that store on the same calendar_2 date one year ago.',
	PLAN_TURNOVER_PY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar_2 date one year ago.',
	PLAN_TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was planned for that store on the same weekday one year ago.',
	PLAN_TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago.',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_GROSS_VAL COMMENT 'The gross turnover which was generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_GROSS_VAL COMMENT 'The gross turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for that store on the given day according to the cash register.',
	EOD_TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.',
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
	RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cash register.',
	EOD_RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.',
	BOOKED_RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.',
	PLAN_RECEIPT_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store and that day.',
	PLAN_RECEIPT_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to that day.',
	PLAN_RECEIPT_PY_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same calendar_2 date one year ago.',
	PLAN_RECEIPT_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar_2 date one year ago.',
	PLAN_RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.',
	PLAN_RECEIPT_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.',
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
	DWH_NODE_CD COMMENT 'The dwh loaded node'
) COMMENT='The Store day level view for Turnover and customer count incl. Time Transformations'
 as SELECT 
main.bus_dt AS cal_dt
,main.int_org_sid AS store_sid
,main.country_org_cd AS country_org_cd
,main.turnover_net_val / fer.exchange_rate AS turnover_net_val
,main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val
,main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val
,main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val
,main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
,main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val
,main.cash_register_turnover_net_val / fer.exchange_rate AS cash_register_turnover_net_val
,main.eod_turnover_net_val / fer.exchange_rate AS eod_turnover_net_val
,main.booked_turnover_net_val / fer.exchange_rate AS booked_turnover_net_val
,main.plan_turnover_net_val / fer.exchange_rate AS plan_turnover_net_val
,main.plan_turnover_bytd_net_val / fer.exchange_rate AS plan_turnover_bytd_net_val
,main.plan_turnover_py_net_val / fer.exchange_rate AS plan_turnover_py_net_val
,main.plan_turnover_py_bytd_net_val / fer.exchange_rate AS plan_turnover_py_bytd_net_val
,main.plan_turnover_py_swday_net_val / fer.exchange_rate AS plan_turnover_py_swday_net_val
,main.plan_turnover_py_swday_bytd_net_val / fer.exchange_rate AS plan_turnover_py_swday_bytd_net_val
,main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val
,main.turnover_bytd_gross_val / fer.exchange_rate AS turnover_bytd_gross_val
,main.turnover_py_gross_val / fer.exchange_rate AS turnover_py_gross_val
,main.turnover_py_bytd_gross_val / fer.exchange_rate AS turnover_py_bytd_gross_val
,main.turnover_py_swday_gross_val / fer.exchange_rate AS turnover_py_swday_gross_val
,main.turnover_py_swday_bytd_gross_val / fer.exchange_rate AS turnover_py_swday_bytd_gross_val
,main.cash_register_turnover_gross_val / fer.exchange_rate AS cash_register_turnover_gross_val
,main.eod_turnover_gross_val / fer.exchange_rate AS eod_turnover_gross_val
,main.sales_net_val / fer.exchange_rate AS sales_net_val
,main.sales_bytd_net_val / fer.exchange_rate AS sales_bytd_net_val
,main.sales_py_net_val / fer.exchange_rate AS sales_py_net_val
,main.sales_py_bytd_net_val / fer.exchange_rate AS sales_py_bytd_net_val
,main.sales_py_swday_net_val / fer.exchange_rate AS sales_py_swday_net_val
,main.sales_py_swday_bytd_net_val / fer.exchange_rate AS sales_py_swday_bytd_net_val
,main.return_net_val / fer.exchange_rate AS return_net_val
,main.return_bytd_net_val / fer.exchange_rate AS return_bytd_net_val
,main.return_py_net_val / fer.exchange_rate AS return_py_net_val
,main.return_py_bytd_net_val / fer.exchange_rate AS return_py_bytd_net_val
,main.return_py_swday_net_val / fer.exchange_rate AS return_py_swday_net_val
,main.return_py_swday_bytd_net_val / fer.exchange_rate AS return_py_swday_bytd_net_val
,fer.src_curr_cd AS curr_cd
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
,main.receipt_cnt AS receipt_cnt
,main.receipt_bytd_cnt AS receipt_bytd_cnt
,main.receipt_py_cnt AS receipt_py_cnt
,main.receipt_py_bytd_cnt AS receipt_py_bytd_cnt
,main.receipt_py_swday_cnt AS receipt_py_swday_cnt
,main.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt
,main.cash_register_receipt_cnt AS cash_register_receipt_cnt
,main.eod_receipt_cnt AS eod_receipt_cnt
,main.booked_receipt_cnt AS booked_receipt_cnt
,main.plan_receipt_cnt AS plan_receipt_cnt
,main.plan_receipt_bytd_cnt AS plan_receipt_bytd_cnt
,main.plan_receipt_py_cnt AS plan_receipt_py_cnt
,main.plan_receipt_py_bytd_cnt AS plan_receipt_py_bytd_cnt
,main.plan_receipt_py_swday_cnt AS plan_receipt_py_swday_cnt
,main.plan_receipt_py_swday_bytd_cnt AS plan_receipt_py_swday_bytd_cnt
,main.sales_variant_sales_cnt AS sales_variant_sales_cnt
,main.sales_variant_sales_bytd_cnt AS sales_variant_sales_bytd_cnt
,main.sales_variant_sales_py_cnt AS sales_variant_sales_py_cnt
,main.sales_variant_sales_py_bytd_cnt AS sales_variant_sales_py_bytd_cnt
,main.sales_variant_sales_py_swday_cnt AS sales_variant_sales_py_swday_cnt
,main.sales_variant_sales_py_swday_bytd_cnt AS sales_variant_sales_py_swday_bytd_cnt
,main.sales_variant_sales_qty AS sales_variant_sales_qty
,main.sales_variant_sales_bytd_qty AS sales_variant_sales_bytd_qty
,main.sales_variant_sales_py_qty AS sales_variant_sales_py_qty
,main.sales_variant_sales_py_bytd_qty AS sales_variant_sales_py_bytd_qty
,main.sales_variant_sales_py_swday_qty AS sales_variant_sales_py_swday_qty
,main.sales_variant_sales_py_swday_bytd_qty AS sales_variant_sales_py_swday_bytd_qty
,main.sales_variant_return_cnt AS sales_variant_return_cnt
,main.sales_variant_return_bytd_cnt AS sales_variant_return_bytd_cnt
,main.sales_variant_return_py_cnt AS sales_variant_return_py_cnt
,main.sales_variant_return_py_bytd_cnt AS sales_variant_return_py_bytd_cnt
,main.sales_variant_return_py_swday_cnt AS sales_variant_return_py_swday_cnt
,main.sales_variant_return_py_swday_bytd_cnt AS sales_variant_return_py_swday_bytd_cnt
,main.sales_variant_return_qty AS sales_variant_return_qty
,main.sales_variant_return_bytd_qty AS sales_variant_return_bytd_qty
,main.sales_variant_return_py_qty AS sales_variant_return_py_qty
,main.sales_variant_return_py_bytd_qty AS sales_variant_return_py_bytd_qty
,main.sales_variant_return_py_swday_qty AS sales_variant_return_py_swday_qty
,main.sales_variant_return_py_swday_bytd_qty AS sales_variant_return_py_swday_bytd_qty
,main.sales_variant_perf_total_cnt AS sales_variant_perf_total_cnt
,main.sales_variant_perf_total_bytd_cnt AS sales_variant_perf_total_bytd_cnt
,main.sales_variant_perf_total_py_cnt AS sales_variant_perf_total_py_cnt
,main.sales_variant_perf_total_py_bytd_cnt AS sales_variant_perf_total_py_bytd_cnt
,main.sales_variant_perf_total_py_swday_cnt AS sales_variant_perf_total_py_swday_cnt
,main.sales_variant_perf_total_py_swday_bytd_cnt AS sales_variant_perf_total_py_swday_bytd_cnt
,main.sales_variant_perf_total_qty AS sales_variant_perf_total_qty
,main.sales_variant_perf_total_bytd_qty AS sales_variant_perf_total_bytd_qty
,main.sales_variant_perf_total_py_qty AS sales_variant_perf_total_py_qty
,main.sales_variant_perf_total_py_bytd_qty AS sales_variant_perf_total_py_bytd_qty
,main.sales_variant_perf_total_py_swday_qty AS sales_variant_perf_total_py_swday_qty
,main.sales_variant_perf_total_py_swday_bytd_qty AS sales_variant_perf_total_py_swday_bytd_qty
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.V_FACT_TURNOVER_BY_STORE_DAY_2 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_2 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE;