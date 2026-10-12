CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_retail_growth_by_store_day_2 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
perf_adj_sales_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were sold in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_cnt INTEGER
OPTIONS(description='The number of sales_2 variant which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were returned in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_qty NUMERIC(29,5)
OPTIONS(description='The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_py_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_py_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_py_swday_qty NUMERIC(29,5)
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_py_swday_bytd_qty NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_2 of measure, such as kg, meter or pieces.'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
turnover_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
turnover_py_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
turnover_py_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
turnover_py_swday_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover which was generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
turnover_py_swday_bytd_net_val NUMERIC(29,5)
OPTIONS(description='The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
receipt_cnt INTEGER
OPTIONS(description='The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_cnt INTEGER
OPTIONS(description='The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_cnt INTEGER
OPTIONS(description='The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
receipt_py_swday_bytd_cnt INTEGER
OPTIONS(description='The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, int_org_sid) NOT ENFORCED
);