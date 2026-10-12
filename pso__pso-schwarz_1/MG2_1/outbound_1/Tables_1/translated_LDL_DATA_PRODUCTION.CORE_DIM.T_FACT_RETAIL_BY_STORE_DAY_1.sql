CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_retail_by_store_day_1 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
sales_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in the given store on the given day. (Weight-based products are not included.)'),
sales_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the given day. (Weight-based products are not included.)'),
sales_py_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same calendar_1 date one year ago. (Weight-based products are not included.)'),
sales_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same calendar_1 date one year ago. (Weight-based products are not included.)'),
sales_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same weekday one year ago. (Weight-based products are not included.)'),
sales_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same weekday one year ago. (Weight-based products are not included.)'),
sales_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which have been sold in the given store on the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar_1 date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_1 date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_cnt INTEGER
OPTIONS(description='The number of sales_1 variant which were returned in the given store on the given day. (Weight-based products are not included.)'),
return_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the given day. (Weight-based products are not included.)'),
return_py_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same calendar_1 date one year ago. (Weight-based products are not included.)'),
return_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same calendar_1 date one year ago. (Weight-based products are not included.)'),
return_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same weekday one year ago. (Weight-based products are not included.)'),
return_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same weekday one year ago. (Weight-based products are not included.)'),
return_qty NUMERIC(29,5)
OPTIONS(description='The total quantiy of weight-based products which were returned in the given store on the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar_1 date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_1 date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_cnt INTEGER
OPTIONS(description='The number of sales_1 variant which were returned in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_qty NUMERIC(29,5)
OPTIONS(description='The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_1 of measure, such as kg, meter or pieces.'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
plan_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which has been planned for that store and that day. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which has been planned for that store up to the given day. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_py_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same calendar_1 date one year ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar_1 date one year ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same weekday one year ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
cash_register_sales_net_val NUMERIC(29,5)
OPTIONS(description='The net amount which was generated by sales_1 in that store on the given day according to the cash register.'),
cash_register_return_net_val NUMERIC(29,5)
OPTIONS(description='The net amount which was generated by returns in that store on the given day according to the cash register.'),
eod_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day according to the end-of-day processing of the retail system. (The turnover is the difference of sales_1 and returns.)'),
booked_turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which has been booked to the store by financial accounting. (The turnover is the difference of sales_1 and returns.)'),
turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_swday_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_py_swday_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
cash_register_sales_gross_val NUMERIC(29,5)
OPTIONS(description='The gross amount which was generated by sales_1 in that store on the given day according to the cash register.'),
cash_register_return_gross_val NUMERIC(29,5)
OPTIONS(description='The gross amount which was generated by returns in that store on the given day according to the cash register.'),
eod_turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the given day according to the end-of-day processing of the retail system.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
receipt_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_1 date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
cash_register_receipt_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cash register.'),
eod_receipt_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.'),
booked_receipt_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.'),
plan_receipt_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store and that day. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store up to that day. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_py_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store on the same calendar_1 date one year ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar_1 date one year ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago. This is the plan value according to the annual planning process for the entire business year.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
cash_register_sales_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net sales_1 amount according to the cash register for that store up to the given day.'),
cash_register_sales_py_net_val NUMERIC(29,5)
OPTIONS(description='The net sales_1 amount which was generated for that store on the same calendar_1 date one year ago according to the cash register.'),
cash_register_sales_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net sales_1 amount according to the cash registe for that store up to the same calendar_1 date one year ago.'),
cash_register_sales_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net sales_1 amount which was generated for that store on the same weekday one year ago according to the cash register.'),
cash_register_sales_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net sales_1 amount according to the cash registe for that store up to the same weekday one year ago.'),
cash_register_return_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net return amount according to the cash register for that store up to the given day.'),
cash_register_return_py_net_val NUMERIC(29,5)
OPTIONS(description='The net return amount which was generated for that store on the same calendar_1 date one year ago according to the cash register.'),
cash_register_return_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net return amount according to the cash registe for that store up to the same calendar_1 date one year ago.'),
cash_register_return_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net return amount which was generated for that store on the same weekday one year ago according to the cash register.'),
cash_register_return_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net return amount according to the cash registe for that store up to the same weekday one year ago.'),
plan_perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of products which are planned to be sold in this store on the given day. This includes both regular products and weight-based products. (1 kg is counted as one piece.) The plan value represents the difference of sales_1 and returns. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is the plan value according to the annual planning process for the entire business year.'),
plan_perf_adj_sales_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the total quantity of products which are planned to be sold in this store up to the given day. This includes both regular products and weight-based products. (1 kg is counted as one piece.) The plan value represents the difference of sales_1 and returns. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is the plan value according to the annual planning process for the entire business year.'),
short_term_plan_perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of products which are planned to be sold in this store on the given day. This includes both regular products and weight-based products. (1 kg is counted as one piece.) The plan value represents the difference of sales_1 and returns. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is the plan value according to the short-term planning process (PEP / Personal-Einsatzplanung).'),
short_term_plan_perf_adj_sales_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the total quantity of products which are planned to be sold in this store up to the given day. This includes both regular products and weight-based products. (1 kg is counted as one piece.) The plan value represents the difference of sales_1 and returns. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is the plan value according to the short-term planning process (PEP / Personal-Einsatzplanung).'),
plan_total_hr_cnt INTEGER
OPTIONS(description='The total number of hours which is planned to be worked in this store on the given day. This does not only represent pure working hours, but includes any kinds of activities for this store, such as training hours. This is the plan value according to the annual planning process for the entire business year.'),
plan_total_hr_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the total number of hours which have been planned to be worked in this store up to the given day. This does not only represent pure working hours, but includes any kinds of activities for this store, such as training hours. This is the plan value according to the annual planning process for the entire business year.'),
short_term_plan_total_hr_cnt INTEGER
OPTIONS(description='The total number of hours which is planned to be worked in this store on the given day. This does not only represent pure working hours, but includes any kinds of activities for this store, such as training hours. This is the plan value according to the short-term planning process (PEP / Personal-Einsatzplanung).'),
short_term_plan_total_hr_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the total number of hours which have been planned to be worked in this store up to the given day. This does not only represent pure working hours, but includes any kinds of activities for this store, such as training hours. This is the plan value according to the short-term planning process (PEP / Personal-Einsatzplanung).'),
perf_adj_sales_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the sales_1 portion of the net turnover which has been generated in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_py_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the sales_1 portion of the net turnover which has been generated in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated in that store on the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the sales_1 portion of the net turnover which has been generated in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the return portion of the net turnover which has been generated in that store up to the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_py_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated in that store on the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the return portion of the net turnover which has been generated in that store up to the same calendar_1 date one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated in that store on the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the return portion of the net turnover which has been generated in that store up to the same weekday one year ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
sales_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same calendar_1 date two years ago. (Weight-based products are not included.)'),
sales_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same calendar_1 date two years ago. (Weight-based products are not included.)'),
sales_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same weekday two years ago. (Weight-based products are not included.)'),
sales_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same weekday two years ago. (Weight-based products are not included.)'),
sales_ppy_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar_1 date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_ppy_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_1 date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_ppy_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
sales_ppy_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same calendar_1 date two years ago. (Weight-based products are not included.)'),
return_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same calendar_1 date two years ago. (Weight-based products are not included.)'),
return_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same weekday two years ago. (Weight-based products are not included.)'),
return_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same weekday two years ago. (Weight-based products are not included.)'),
return_ppy_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar_1 date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_ppy_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_1 date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_ppy_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_ppy_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday two years ago. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
turnover_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same weekday two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
plan_turnover_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same calendar_1 date two years ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same calendar_1 date two years ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was planned for that store on the same weekday two years ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
plan_turnover_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday two years ago. (The turnover is the difference of sales_1 and returns.) This is the plan value according to the annual planning process for the entire business year.'),
cash_register_sales_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The net sales_1 amount which was generated for that store on the same calendar_1 date two years ago according to the cash register.'),
cash_register_sales_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net sales_1 amount according to the cash registe for that store up to the same calendar_1 date two years ago.'),
cash_register_sales_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net sales_1 amount which was generated for that store on the same weekday two years ago according to the cash register.'),
cash_register_sales_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net sales_1 amount according to the cash registe for that store up to the same weekday two years ago.'),
cash_register_return_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The net return amount which was generated for that store on the same calendar_1 date two years ago according to the cash register.'),
cash_register_return_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net return amount according to the cash registe for that store up to the same calendar_1 date two years ago.'),
cash_register_return_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net return amount which was generated for that store on the same weekday two years ago according to the cash register.'),
cash_register_return_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net return amount according to the cash registe for that store up to the same weekday two years ago.'),
turnover_ppy_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_swday_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover which was generated for that store on the same weekday two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
turnover_ppy_swday_bytd_gross_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the gross turnover for that store up to the same weekday two years ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns.)'),
perf_adj_sales_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were sold in that store on the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been sold in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_ppy_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_ppy_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_ppy_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_ppy_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the sales_1 portion of the net turnover which has been generated in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated in that store on the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_sales_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the sales_1 portion of the net turnover which has been generated in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 variants which were returned in that store on the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 variants which have been returned in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_ppy_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_ppy_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_ppy_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_ppy_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_ppy_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated in that store on the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_ppy_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the return portion of the net turnover which has been generated in that store up to the same calendar_1 date two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_ppy_swday_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated in that store on the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_ppy_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the return portion of the net turnover which has been generated in that store up to the same weekday two years ago. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
receipt_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_1 date two years ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday two years ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday two years ago. (This is the consolidated amount after applying the priority logic.)'),
plan_receipt_ppy_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store on the same calendar_1 date two years ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_ppy_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar_1 date two years ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_ppy_swday_cnt INTEGER
OPTIONS(description='The number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store on the same weekday two years ago. This is the plan value according to the annual planning process for the entire business year.'),
plan_receipt_ppy_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_1 transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday two years ago. This is the plan value according to the annual planning process for the entire business year.'),
emp_hr_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the given day.'),
emp_hr_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the given date.'),
emp_hr_py_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent calendar_1 date one year ago.'),
emp_hr_py_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent calendar_1 date one year ago.'),
emp_hr_py_swday_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent weekday one year ago.'),
emp_hr_py_swday_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent weekday one year ago.'),
emp_hr_ppy_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent calendar_1 date two years ago.'),
emp_hr_ppy_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent calendar_1 date two years ago.'),
emp_hr_ppy_swday_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent weekday two years ago.'),
emp_hr_ppy_swday_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent weekday two years ago.'),
PRIMARY KEY (bus_dt, int_org_sid) NOT ENFORCED
);