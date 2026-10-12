CREATE OR REPLACE VIEW  fe_mstr_gf_lead.v_fact_retail_by_store_day_2(
	cal_dt COMMENT 'The business date to which the meASures are related.' 
	, store_sid COMMENT 'Th,e unique identifier (surrogate key) for a store.' 
	, country_org_cd COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)' 
	/* Turnover */	
	, turnover_net_val COMMENT 'The net turnover which wAS generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_net_val COMMENT 'The net turnover which wAS generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_swday_net_val COMMENT 'The net turnover which wAS generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_swday_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, cash_register_turnover_net_val COMMENT 'The net turnover which wAS generated for that store on the given day according to the cASh register.' 
	, eod_turnover_net_val COMMENT 'The net turnover which wAS generated for that store on the given day according to the end-of-day processing of the retail system.' 
	, booked_turnover_net_val COMMENT 'The net turnover which hAS been booked to the store by financial accounting.' 
	, plan_turnover_net_val COMMENT 'The net turnover which hAS been planned for that store and that day.' 
	, plan_turnover_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which hAS been planned for that store up to the given day.' 
	, plan_turnover_py_net_val COMMENT 'The net turnover which wAS planned for that store on the same calendar_2 date one year ago.' 
	, plan_turnover_py_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which wAS planned for that store up to the same calendar_2 date one year ago.' 
	, plan_turnover_py_swday_net_val COMMENT 'The net turnover which wAS planned for that store on the same weekday one year ago.' 
	, plan_turnover_py_swday_bytd_net_val COMMENT 'The business-year-to-date sum of the net turnover which wAS planned for that store up to the same weekday one year ago.' 
	, turnover_gross_val COMMENT 'The gross turnover which wAS generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_gross_val COMMENT 'The gross turnover which wAS generated for that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_swday_gross_val COMMENT 'The gross turnover which wAS generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, turnover_py_swday_bytd_gross_val COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, cash_register_turnover_gross_val COMMENT 'The gross turnover which wAS generated for that store on the given day according to the cASh register.' 
	, eod_turnover_gross_val COMMENT 'The gross turnover which wAS generated for that store on the given day according to the end-of-day processing of the retail system.' 
	/* Sales_2 Net Val*/	
	, sales_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, sales_bytd_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for business year-to-date.'
	, sales_py_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous year.'
	, sales_py_bytd_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_swday_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_bytd_net_val COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Return Net Val */
	, return_net_val COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, return_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for business year-to-date.'
	, return_py_net_val COMMENT 'The reurn portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous year.'
	, return_py_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, return_py_swday_net_val COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Currency */
	, curr_cd COMMENT 'The code identifying the currency according to ISO-4217.' 
	, curr_group_fg COMMENT 'Flag for Group Currency' 
	, curr_local_fg COMMENT 'Flag for Local Currency'
	/* Receipts */		
	, receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)' 
	, receipt_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)' 
	, receipt_py_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, receipt_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar_2 date one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, receipt_py_swday_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, receipt_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)' 
	, cash_register_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cASh register.' 
	, eod_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.' 
	, booked_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.' 
	, plan_receipt_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store and that day.' 
	, plan_receipt_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to that day.' 
	, plan_receipt_py_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same calendar_2 date one year ago.' 
	, plan_receipt_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar_2 date one year ago.' 
	, plan_receipt_py_swday_cnt COMMENT 'The number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.' 
	, plan_receipt_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.' 
	/* Sales_2 */
	, sales_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'
	, sales_bytd_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for business year-to-date.'
	, sales_py_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for previous year.'
	, sales_py_bytd_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_swday_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_bytd_cnt COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	, sales_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day.'
	, sales_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for business year-to-date.'
	, sales_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for previous year.'
	, sales_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Return */
	, return_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'
	, return_bytd_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for business year-to-date.'
	, return_py_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for previous year.'
	, return_py_bytd_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, return_py_swday_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_bytd_cnt COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day.'
	, return_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for business year-to-date.'
	, return_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for previous year.'
	, return_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, return_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Performance adjusted sales_2 without specific price range */
	, perf_adj_sales_cnt COMMENT 'The number of sales_2 variants which were sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_cnt COMMENT 'The number of sales_2 variants which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_swday_cnt COMMENT 'The number of sales_2 variants which were sold in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_qty COMMENT 'The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_sales_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_sales_py_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_sales_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_sales_py_swday_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_sales_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	/* Performance adjusted returns without specific price range */	
	, perf_adj_return_cnt COMMENT 'The number of sales_2 variant which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_cnt COMMENT 'The number of sales_2 variants which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_swday_cnt COMMENT 'The number of sales_2 variants which were returned in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_qty COMMENT 'The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_return_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_return_py_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_return_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_return_py_swday_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	, perf_adj_return_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)' 
	/* Performance adjusted totals without specific price range */	
	, perf_adj_total_cnt COMMENT 'Total number of sales_2 and returns without specific price range.'
	, perf_adj_total_bytd_cnt COMMENT 'Total number of sales_2 and returns without specific price range. This is for business year-to-date.'
	, perf_adj_total_py_cnt COMMENT 'Total number of sales_2 and returns without specific price range. This is for previous year.'
	, perf_adj_total_py_bytd_cnt COMMENT 'Total number of sales_2 and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_total_py_swday_cnt COMMENT 'Total number of sales_2 and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_total_py_swday_bytd_cnt COMMENT 'Total number of sales_2 and returns without specific price range. This is for same weekday of previous year-to-date.'
	, perf_adj_total_qty COMMENT 'Total quantity of sales_2 and returns without specific price range.'
	, perf_adj_total_bytd_qty COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for business year-to-date.'
	, perf_adj_total_py_qty COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for previous year.'
	, perf_adj_total_py_bytd_qty COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_total_py_swday_qty COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_total_py_swday_bytd_qty COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for same weekday of previous year-to-date.'
	, dwh_created_tmsp COMMENT 'the point in time when this record was created in the data warehouse.' 
	, dwh_updated_tmsp COMMENT 'the point in time when this record was created or last updated.' 
	, dwh_load_id COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)' 
	, dwh_node_cd COMMENT 'the dwh loaded node'
) COMMENT = 'The Store day level view for Turnover and customer count incl. Time Transformations'
 AS SELECT main.bus_dt AS cal_dt
	, main.int_org_sid AS store_sid
	, main.country_org_cd AS country_org_cd
	/* Turnover */	
	, main.turnover_net_val / fer.exchange_rate AS turnover_net_val
	, main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val
	, main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val
	, main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val
	, main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
	, main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val
	, (COALESCE(main.sales_net_val, 0) + COALESCE(main.return_net_val, 0)) / fer.exchange_rate AS cash_register_turnover_net_val
	, main.eod_turnover_net_val / fer.exchange_rate AS eod_turnover_net_val
	, main.booked_turnover_net_val / fer.exchange_rate AS booked_turnover_net_val
	, main.plan_turnover_net_val / fer.exchange_rate AS plan_turnover_net_val
	, main.plan_turnover_bytd_net_val / fer.exchange_rate AS plan_turnover_bytd_net_val
	, main.plan_turnover_py_net_val / fer.exchange_rate AS plan_turnover_py_net_val
	, main.plan_turnover_py_bytd_net_val / fer.exchange_rate AS plan_turnover_py_bytd_net_val
	, main.plan_turnover_py_swday_net_val / fer.exchange_rate AS plan_turnover_py_swday_net_val
	, main.plan_turnover_py_swday_bytd_net_val / fer.exchange_rate AS plan_turnover_py_swday_bytd_net_val
	, main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val
	, main.turnover_bytd_gross_val / fer.exchange_rate AS turnover_bytd_gross_val
	, main.turnover_py_gross_val / fer.exchange_rate AS turnover_py_gross_val
	, main.turnover_py_bytd_gross_val / fer.exchange_rate AS turnover_py_bytd_gross_val
	, main.turnover_py_swday_gross_val / fer.exchange_rate AS turnover_py_swday_gross_val
	, main.turnover_py_swday_bytd_gross_val / fer.exchange_rate AS turnover_py_swday_bytd_gross_val
	, (COALESCE(main.cash_register_sales_gross_val, 0) + COALESCE(main.cash_register_return_gross_val, 0)) / fer.exchange_rate AS cash_register_turnover_gross_val
	, main.eod_turnover_gross_val / fer.exchange_rate AS eod_turnover_gross_val
	/* Sales_2 Net Val*/		
	, main.sales_net_val / fer.exchange_rate AS sales_net_val
	, main.sales_bytd_net_val / fer.exchange_rate AS sales_bytd_net_val
	, main.sales_py_net_val / fer.exchange_rate AS sales_py_net_val
	, main.sales_py_bytd_net_val / fer.exchange_rate AS sales_py_bytd_net_val
	, main.sales_py_swday_net_val / fer.exchange_rate AS sales_py_swday_net_val
	, main.sales_py_swday_bytd_net_val / fer.exchange_rate AS sales_py_swday_bytd_net_val
	/* Return Net Val */	
	, main.return_net_val / fer.exchange_rate AS return_net_val
	, main.return_bytd_net_val / fer.exchange_rate AS return_bytd_net_val
	, main.return_py_net_val / fer.exchange_rate AS return_py_net_val
	, main.return_py_bytd_net_val / fer.exchange_rate AS return_py_bytd_net_val
	, main.return_py_swday_net_val / fer.exchange_rate AS return_py_swday_net_val
	, main.return_py_swday_bytd_net_val / fer.exchange_rate AS return_py_swday_bytd_net_val
	/* Currency */	
	, fer.src_curr_cd AS curr_cd
	, DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
	, DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
	/* Receipts */	
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
	/* Sales_2 */	
	, COALESCE(main.sales_cnt,0) AS sales_cnt
	, COALESCE(main.sales_bytd_cnt,0) AS sales_bytd_cnt
	, COALESCE (main.sales_py_cnt,0) AS sales_py_cnt
	, COALESCE (main.sales_py_bytd_cnt,0) AS sales_py_bytd_cnt
	, COALESCE (main.sales_py_swday_cnt ,0)AS sales_py_swday_cnt
	, COALESCE (main.sales_py_swday_bytd_cnt,0) AS sales_py_swday_bytd_cnt
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_qty*0.453592 ELSE main.sales_qty END ,0) AS sales_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_bytd_qty*0.453592 ELSE main.sales_bytd_qty END ,0) AS sales_bytd_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_py_qty*0.453592 ELSE main.sales_py_qty END ,0) AS sales_py_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_py_bytd_qty*0.453592 ELSE main.sales_py_bytd_qty END ,0) AS sales_py_bytd_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_py_swday_qty*0.453592  ELSE main.sales_py_swday_qty END ,0) AS sales_py_swday_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.sales_py_swday_bytd_qty*0.453592 ELSE main.sales_py_swday_bytd_qty  END ,0) AS sales_py_swday_bytd_qty
	/* Return */	
	, COALESCE (main.return_cnt,0) AS return_cnt
	, COALESCE (main.return_bytd_cnt,0) AS return_bytd_cnt
	, COALESCE (main.return_py_cnt,0) AS return_py_cnt
	, COALESCE (main.return_py_bytd_cnt,0) AS return_py_bytd_cnt
	, COALESCE (main.return_py_swday_cnt,0) AS return_py_swday_cnt
	, COALESCE (main.return_py_swday_bytd_cnt,0) AS return_py_swday_bytd_cnt
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_qty *0.453592 ELSE main.return_qty END,0) AS return_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_bytd_qty*0.453592 ELSE main.return_bytd_qty END,0) AS return_bytd_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_py_qty*0.453592 ELSE main.return_py_qty END,0) AS return_py_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_py_bytd_qty*0.453592 ELSE main.return_py_bytd_qty END,0) AS return_py_bytd_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_py_swday_qty*0.453592 ELSE main.return_py_swday_qty END,0) AS return_py_swday_qty
	, COALESCE (CASE WHEN main.country_org_cd = 'US' THEN main.return_py_swday_bytd_qty*0.453592 ELSE main.return_py_swday_bytd_qty END,0) AS return_py_swday_bytd_qty
	/* Performance adjusted sales_2 without specific price range */	
	, main.perf_adj_sales_cnt AS perf_adj_sales_cnt
	, main.perf_adj_sales_bytd_cnt AS perf_adj_sales_bytd_cnt
	, main.perf_adj_sales_py_cnt AS perf_adj_sales_py_cnt
	, main.perf_adj_sales_py_bytd_cnt AS perf_adj_sales_py_bytd_cnt
	, main.perf_adj_sales_py_swday_cnt AS perf_adj_sales_py_swday_cnt
	, main.perf_adj_sales_py_swday_bytd_cnt AS perf_adj_sales_py_swday_bytd_cnt
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_qty*0.453592 ELSE main.perf_adj_sales_qty END AS perf_adj_sales_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_bytd_qty*0.453592 ELSE main.perf_adj_sales_bytd_qty END AS perf_adj_sales_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_py_qty*0.453592 ELSE main.perf_adj_sales_py_qty END AS perf_adj_sales_py_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_py_bytd_qty*0.453592 ELSE main.perf_adj_sales_py_bytd_qty END AS perf_adj_sales_py_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_py_swday_qty*0.453592 ELSE main.perf_adj_sales_py_swday_qty END AS perf_adj_sales_py_swday_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_sales_py_swday_bytd_qty*0.453592 ELSE main.perf_adj_sales_py_swday_bytd_qty END AS perf_adj_sales_py_swday_bytd_qty
	/* Performance adjusted returns without specific price range */		
	, main.perf_adj_return_cnt AS perf_adj_return_cnt
	, main.perf_adj_return_bytd_cnt AS perf_adj_return_bytd_cnt
	, main.perf_adj_return_py_cnt AS perf_adj_return_py_cnt
	, main.perf_adj_return_py_bytd_cnt AS perf_adj_return_py_bytd_cnt
	, main.perf_adj_return_py_swday_cnt AS perf_adj_return_py_swday_cnt
	, main.perf_adj_return_py_swday_bytd_cnt AS perf_adj_return_py_swday_bytd_cnt
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_qty*0.453592 ELSE main.perf_adj_return_qty END AS perf_adj_return_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_bytd_qty*0.453592 ELSE main.perf_adj_return_bytd_qty END AS perf_adj_return_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_py_qty*0.453592 ELSE main.perf_adj_return_py_qty END AS perf_adj_return_py_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_py_bytd_qty*0.453592 ELSE main.perf_adj_return_py_bytd_qty END AS perf_adj_return_py_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_py_swday_qty*0.453592 ELSE main.perf_adj_return_py_swday_qty END AS perf_adj_return_py_swday_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_return_py_swday_bytd_qty*0.453592 ELSE main.perf_adj_return_py_swday_bytd_qty END AS perf_adj_return_py_swday_bytd_qty
	/* Performance adjusted totals without specific price range */		
	, main.perf_adj_total_cnt AS perf_adj_total_cnt
	, main.perf_adj_total_bytd_cnt AS perf_adj_total_bytd_cnt
	, main.perf_adj_total_py_cnt AS perf_adj_total_py_cnt
	, main.perf_adj_total_py_bytd_cnt AS perf_adj_total_py_bytd_cnt
	, main.perf_adj_total_py_swday_cnt AS perf_adj_total_py_swday_cnt
	, main.perf_adj_total_py_swday_bytd_cnt AS perf_adj_total_py_swday_bytd_cnt
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_qty*0.453592 ELSE main.perf_adj_total_qty END AS perf_adj_total_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_bytd_qty*0.453592 ELSE main.perf_adj_total_bytd_qty END AS perf_adj_total_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_py_qty*0.453592 ELSE main.perf_adj_total_py_qty END AS perf_adj_total_py_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_py_bytd_qty*0.453592 ELSE main.perf_adj_total_py_bytd_qty END AS perf_adj_total_py_bytd_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_py_swday_qty*0.453592 ELSE main.perf_adj_total_py_swday_qty END AS perf_adj_total_py_swday_qty
	, CASE WHEN main.country_org_cd = 'US' THEN main.perf_adj_total_py_swday_bytd_qty*0.453592 ELSE main.perf_adj_total_py_swday_bytd_qty END AS perf_adj_total_py_swday_bytd_qty
	, main.dwh_created_tmsp AS dwh_created_tmsp
	, main.dwh_updated_tmsp AS dwh_updated_tmsp
	, main.dwh_load_id AS dwh_load_id
	, main.dwh_node_cd AS dwh_node_cd 
FROM core_dim.v_fact_retail_by_store_day_2 main
INNER JOIN  core_dim.t_fact_exchange_rate_2 fer
	ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
	AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
	AND fer.active_fg = TRUE
;