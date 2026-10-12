CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_retail_by_store_day_exchange_rate_type_benchmark (benchmark_type_id
OPTIONS(description='BENCHMARK Type Identifier'), cal_dt
OPTIONS(description='The business date to which the measures are related.'), store_sid
OPTIONS(description='Th,e unique identifier (surrogate key) for a store.'), country_org_cd
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
exchange_rate_type_cd OPTIONS(description='The Exchange Rate Type Code'), exchange_bus_year
OPTIONS(description='The Exchange Rate of the business year'), turnover_net_val
OPTIONS(description='The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_net_val
OPTIONS(description='The net tur\n\t\n\tnover which was generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_net_val
OPTIONS(description='The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_turnover_net_val
OPTIONS(description='The net turnover which was generated for that store on the given day according to the cash register.'),
eod_turnover_net_val
OPTIONS(description='The net turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'),
booked_turnover_net_val
OPTIONS(description='The net turnover which has been booked to the store by financial accounting.'),
plan_turnover_net_val OPTIONS(description='The net turnover which has been planned for that store and that day.'),
plan_turnover_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover which has been planned for that store up to the given day.'),
plan_turnover_py_net_val
OPTIONS(description='The net turnover which was planned for that store on the same calendar date one year ago.'),
plan_turnover_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar date one year ago.'),
plan_turnover_py_swday_net_val
OPTIONS(description='The net turnover which was planned for that store on the same weekday one year ago.'),
plan_turnover_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago.'),
turnover_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_bytd_gross_val
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_bytd_gross_val
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_bytd_gross_val
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_turnover_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the given day according to the cash register.'),
eod_turnover_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'),
receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cash register.'),
eod_receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.'),
booked_receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.'),
plan_receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store and that day.'),
plan_receipt_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to that day.'),
plan_receipt_py_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same calendar date one year ago.'),
plan_receipt_py_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar date one year ago.'),
plan_receipt_py_swday_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.'),
plan_receipt_py_swday_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd OPTIONS(description='The dwh loaded node'))
OPTIONS(DESCRIPTION = `THE STORE DAY LEVEL VIEW FOR TURNOVER AND CUSTOMER COUNT INCL. TIME TRANSFORMATIONS`) AS SELECT
 main.benchmarking_type_id AS benchmark_type_id,
 main.bus_dt AS cal_dt,
 main.int_org_sid AS store_sid,
 main.country_org_cd,
 fer.exchange_rate_type_cd,
 fer.bus_year AS exchange_bus_year,
  main.turnover_net_val / fer.exchange_rate AS turnover_net_val,
  main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val,
  main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val,
  main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val,
  main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val,
  main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val,
  main.cash_register_turnover_net_val / fer.exchange_rate AS cash_register_turnover_net_val,
  main.eod_turnover_net_val / fer.exchange_rate AS eod_turnover_net_val,
  main.booked_turnover_net_val / fer.exchange_rate AS booked_turnover_net_val,
  main.plan_turnover_net_val / fer.exchange_rate AS plan_turnover_net_val,
  main.plan_turnover_bytd_net_val / fer.exchange_rate AS plan_turnover_bytd_net_val,
  main.plan_turnover_py_net_val / fer.exchange_rate AS plan_turnover_py_net_val,
  main.plan_turnover_py_bytd_net_val / fer.exchange_rate AS plan_turnover_py_bytd_net_val,
  main.plan_turnover_py_swday_net_val / fer.exchange_rate AS plan_turnover_py_swday_net_val,
  main.plan_turnover_py_swday_bytd_net_val / fer.exchange_rate AS plan_turnover_py_swday_bytd_net_val,
  main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val,
  main.turnover_bytd_gross_val / fer.exchange_rate AS turnover_bytd_gross_val,
  main.turnover_py_gross_val / fer.exchange_rate AS turnover_py_gross_val,
  main.turnover_py_bytd_gross_val / fer.exchange_rate AS turnover_py_bytd_gross_val,
  main.turnover_py_swday_gross_val / fer.exchange_rate AS turnover_py_swday_gross_val,
  main.turnover_py_swday_bytd_gross_val / fer.exchange_rate AS turnover_py_swday_bytd_gross_val,
  main.cash_register_turnover_gross_val / fer.exchange_rate AS cash_register_turnover_gross_val,
  main.eod_turnover_gross_val / fer.exchange_rate AS eod_turnover_gross_val,
 fer.src_curr_cd AS curr_cd,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 main.receipt_cnt,
 main.receipt_bytd_cnt,
 main.receipt_py_cnt,
 main.receipt_py_bytd_cnt,
 main.receipt_py_swday_cnt,
 main.receipt_py_swday_bytd_cnt,
 main.cash_register_receipt_cnt,
 main.eod_receipt_cnt,
 main.booked_receipt_cnt,
 main.plan_receipt_cnt,
 main.plan_receipt_bytd_cnt,
 main.plan_receipt_py_cnt,
 main.plan_receipt_py_bytd_cnt,
 main.plan_receipt_py_swday_cnt,
 main.plan_receipt_py_swday_bytd_cnt,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_benchmark AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.src_curr_cd = 'EUR'
 OR fer.src_curr_cd = fer.tgt_curr_cd;