create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_RETAIL_BY_STORE_DAY_EXCHANGE_RATE_TYPE(
	CAL_DT COMMENT 'The business date to which the meASures are related.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for a store.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
	EXCHANGE_RATE_TYPE_CD COMMENT 'The Exchange Rate Type Code',
	EXCHANGE_BUS_YEAR COMMENT 'The Exchange Rate of the business year',
	TURNOVER_NET_VAL COMMENT 'The net turnover which wAS generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_NET_VAL COMMENT 'The net turnover which wAS generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which wAS generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_TURNOVER_NET_VAL COMMENT 'The net turnover which wAS generated for that store on the given day according to the cASh register.',
	EOD_TURNOVER_NET_VAL COMMENT 'The net turnover which wAS generated for that store on the given day according to the end-of-day processing of the retail system.',
	BOOKED_TURNOVER_NET_VAL COMMENT 'The net turnover which hAS been booked to the store by financial accounting.',
	PLAN_TURNOVER_NET_VAL COMMENT 'The net turnover which hAS been planned for that store and that day.',
	PLAN_TURNOVER_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which hAS been planned for that store up to the given day.',
	PLAN_TURNOVER_PY_NET_VAL COMMENT 'The net turnover which wAS planned for that store on the same calendar date one year ago.',
	PLAN_TURNOVER_PY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which wAS planned for that store up to the same calendar date one year ago.',
	PLAN_TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which wAS planned for that store on the same weekday one year ago.',
	PLAN_TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The business-year-to-date sum of the net turnover which was planned for that store up to the same weekday one year ago.',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which wAS generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_GROSS_VAL COMMENT 'The gross turnover which wAS generated for that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_GROSS_VAL COMMENT 'The gross turnover which wAS generated for that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	TURNOVER_PY_SWDAY_BYTD_GROSS_VAL COMMENT 'The business-year-to-date sum of the gross turnover for that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_TURNOVER_GROSS_VAL COMMENT 'The gross turnover which wAS generated for that store on the given day according to the cASh register.',
	EOD_TURNOVER_GROSS_VAL COMMENT 'The gross turnover which wAS generated for that store on the given day according to the end-of-day processing of the retail system.',
	SALES_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	SALES_BYTD_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.',
	SALES_PY_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.',
	SALES_PY_BYTD_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_SWDAY_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_NET_VAL COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	RETURN_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.',
	RETURN_PY_NET_VAL COMMENT 'The reurn portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.',
	RETURN_PY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_SWDAY_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the given day. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same calendar date one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	RECEIPT_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been performed in that store up to the same weekday one year ago. (This is the consolidated amount after applying the priority logic.)',
	CASH_REGISTER_RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according to the cASh register.',
	EOD_RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day according ot the end-of-day processing of the retail system.',
	BOOKED_RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been booked to the store by financial accounting.',
	PLAN_RECEIPT_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been planned for that store and that day.',
	PLAN_RECEIPT_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to that day.',
	PLAN_RECEIPT_PY_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same calendar date one year ago.',
	PLAN_RECEIPT_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same calendar date one year ago.',
	PLAN_RECEIPT_PY_SWDAY_CNT COMMENT 'The number of sales transactions (i.e. the number of receipts) which have been planned for that store on the same weekday one year ago.',
	PLAN_RECEIPT_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales transactions (i.e. the number of receipts) which have been planned for that store up to the same weekday one year ago.',
	SALES_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)',
	SALES_BYTD_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for business year-to-date.',
	SALES_PY_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous year.',
	SALES_PY_BYTD_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_SWDAY_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	SALES_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day.',
	SALES_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for business year-to-date.',
	SALES_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous year.',
	SALES_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)',
	RETURN_BYTD_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for business year-to-date.',
	RETURN_PY_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous year.',
	RETURN_PY_BYTD_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_SWDAY_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day.',
	RETURN_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for business year-to-date.',
	RETURN_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous year.',
	RETURN_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	PERF_ADJ_SALES_CNT COMMENT 'The number of sales variants which were sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_CNT COMMENT 'The number of sales variants which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_SWDAY_CNT COMMENT 'The number of sales variants which were sold in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_QTY COMMENT 'The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_SALES_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_SALES_PY_QTY COMMENT 'The total quantity of weight-based products which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_SALES_PY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_SALES_PY_SWDAY_QTY COMMENT 'The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_CNT COMMENT 'The number of sales variant which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_CNT COMMENT 'The number of sales variants which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_SWDAY_CNT COMMENT 'The number of sales variants which were returned in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_QTY COMMENT 'The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_PY_QTY COMMENT 'The total quantity of weight-based products which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_PY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_PY_SWDAY_QTY COMMENT 'The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)',
	PERF_ADJ_TOTAL_CNT COMMENT 'Total number of sales and returns without specific price range.',
	PERF_ADJ_TOTAL_BYTD_CNT COMMENT 'Total number of sales and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TOTAL_PY_CNT COMMENT 'Total number of sales and returns without specific price range. This is for previous year.',
	PERF_ADJ_TOTAL_PY_BYTD_CNT COMMENT 'Total number of sales and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_CNT COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TOTAL_QTY COMMENT 'Total quantity of sales and returns without specific price range.',
	PERF_ADJ_TOTAL_BYTD_QTY COMMENT 'Total quantity of sales and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TOTAL_PY_QTY COMMENT 'Total quantity of sales and returns without specific price range. This is for previous year.',
	PERF_ADJ_TOTAL_PY_BYTD_QTY COMMENT 'Total quantity of sales and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_QTY COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year-to-date.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record wAS created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record wAS created or lASt updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which hAS done the lASt update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The dwh loaded node'
) as SELECT main.bus_dt AS cal_dt
	, main.int_org_sid AS store_sid
	, main.country_org_cd AS country_org_cd
	, fer.exchange_rate_type_cd AS exchange_rate_type_cd
	, fer.bus_year AS exchange_bus_year
	
	, main.turnover_net_val / fer.exchange_rate AS turnover_net_val
	, main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val
	, main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val
	, main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val
	, main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
	, main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val
	, (main.sales_net_val + main.return_net_val) / fer.exchange_rate AS cash_register_turnover_net_val
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
	, (main.cash_register_sales_gross_val + main.cash_register_return_gross_val) / fer.exchange_rate AS cash_register_turnover_gross_val
	, main.eod_turnover_gross_val / fer.exchange_rate AS eod_turnover_gross_val
	
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
	, DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
	
	, main.receipt_cnt AS receipt_cnt
	, main.receipt_bytd_cnt AS receipt_bytd_cnt
	, main.receipt_py_cnt AS receipt_py_cnt
	, main.receipt_py_bytd_cnt AS receipt_py_bytd_cnt
	, main.receipt_py_swday_cnt AS receipt_py_swday_cnt
	, main.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt
	, main.cASh_register_receipt_cnt AS cASh_register_receipt_cnt
	, main.eod_receipt_cnt AS eod_receipt_cnt
	, main.booked_receipt_cnt AS booked_receipt_cnt
	, main.plan_receipt_cnt AS plan_receipt_cnt
	, main.plan_receipt_bytd_cnt AS plan_receipt_bytd_cnt
	, main.plan_receipt_py_cnt AS plan_receipt_py_cnt
	, main.plan_receipt_py_bytd_cnt AS plan_receipt_py_bytd_cnt
	, main.plan_receipt_py_swday_cnt AS plan_receipt_py_swday_cnt
	, main.plan_receipt_py_swday_bytd_cnt AS plan_receipt_py_swday_bytd_cnt
	
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
FROM core_dim.v_fact_retail_by_store_day main
INNER JOIN  core_dim.t_fact_exchange_rate fer
	ON main.curr_cd = fer.tgt_curr_cd
WHERE (fer.src_curr_cd = 'EUR' 
	OR fer.src_curr_cd = fer.tgt_curr_cd
	)
;