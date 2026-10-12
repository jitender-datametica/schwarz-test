CREATE OR REPLACE TABLE ldl_data_production_eval.t_adhoc_cgw_fact_retail_by_store_day_benchmark (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
parent_int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization which is the parent in the hierarchy for given internal organization. I.e. if the internal organization is a store, then this attribute is the surrogate key of the sales manager district.'),
parent_int_org_nat_key_nr STRING(250)
OPTIONS(description='The natural key of the internal organization which is the parent in the hierarchy for given internal organization. Benchmarking Szenario/Level: account manager <-> (sales) company => sales_company_nr; Benchmarking Szenario/Level: company <-> country  => country_org_cd; Benchmarking Szenario/Level: region <-> INTEGER (nternational or all) => fix value for international view of all data (currently\'INTEGER\')'),
benchmarking_type_id INTEGER NOT NULL
OPTIONS(description='The benchmarking type identifies the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day according to the cash register.'),
eod_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'),
booked_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which has been booked to the store by financial accounting.'),
plan_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which has been planned for that store and that day.'),
plan_turnover_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which has been planned for that store up to the given day.'),
plan_turnover_py_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same calendar date one year ago.'),
plan_turnover_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar date one year ago.'),
plan_turnover_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same weekday one year ago.'),
plan_turnover_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago.'),
turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
turnover_py_swday_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the given day according to the cash register.'),
eod_turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
receipt_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_receipt_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cash register.'),
eod_receipt_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.'),
booked_receipt_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.'),
plan_receipt_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store and that day.'),
plan_receipt_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to that day.'),
plan_receipt_py_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same calendar date one year ago.'),
plan_receipt_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar date one year ago.'),
plan_receipt_py_swday_cnt INTEGER
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.'),
plan_receipt_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, int_org_sid, benchmarking_type_id) NOT ENFORCED
);