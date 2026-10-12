CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_TURNOVER_BY_STORE_DAY_BENCHMARK_2(
benchmark_type_id COMMENT 'BENCHMARK Type Identifier'   
,cal_dt COMMENT 'The business date to which the measures are related.'
,store_sid COMMENT 'Th,e unique identifier (surrogate key) for a store.'
,country_org_cd COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'
,turnover_net_val COMMENT 'The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'
,turnover_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_net_val COMMENT 'The net turnover which was generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_swday_net_val COMMENT 'The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_swday_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,cash_register_turnover_net_val COMMENT 'The net turnover which was generated for that store on the given day according to the cash register.'
,eod_turnover_net_val COMMENT 'The net turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'
,booked_turnover_net_val COMMENT 'The net turnover which has been booked to the store by financial accounting.'
,plan_turnover_net_val COMMENT 'The net turnover which has been planned for that store and that day.'
,plan_turnover_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which has been planned for that store up to the given day.'
,plan_turnover_py_net_val COMMENT 'The net turnover which was planned for that store on the same calendar_2 date one year ago.'
,plan_turnover_py_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar_2 date one year ago.'
,plan_turnover_py_swday_net_val COMMENT 'The net turnover which was planned for that store on the same weekday one year ago.'
,plan_turnover_py_swday_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago.'
,turnover_gross_val COMMENT 'The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'
,turnover_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_gross_val COMMENT 'The gross turnover which was generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_swday_gross_val COMMENT 'The gross turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,turnover_py_swday_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,cash_register_turnover_gross_val COMMENT 'The gross turnover which was generated for that store on the given day according to the cash register.'
,eod_turnover_gross_val COMMENT 'The gross turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'
,curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
,curr_group_fg COMMENT 'Flag for Group Currency'
,curr_local_fg COMMENT 'Flag for Local Currency'
,receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'
,receipt_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)'
,receipt_py_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,receipt_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'
,receipt_py_swday_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,receipt_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'
,cash_register_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cash register.'
,eod_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.'
,booked_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.'
,plan_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store and that day.'
,plan_receipt_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to that day.'
,plan_receipt_py_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same calendar_2 date one year ago.'
,plan_receipt_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar_2 date one year ago.'
,plan_receipt_py_swday_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.'
,plan_receipt_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The dwh loaded node'
) COMMENT='The Store day level view for Turnover and customer count incl. Time Transformations'
AS 
SELECT 
 main.BENCHMARKING_TYPE_ID AS benchmark_type_id
,main.bus_dt AS cal_dt
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
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_FACT_TURNOVER_BY_STORE_DAY_BENCHMARK main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_2 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE;