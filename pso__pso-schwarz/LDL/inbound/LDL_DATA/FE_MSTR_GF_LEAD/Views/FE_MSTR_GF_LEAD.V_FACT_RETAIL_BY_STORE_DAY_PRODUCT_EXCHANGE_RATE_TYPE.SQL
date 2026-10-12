/* The data aggregation level for this view based on the source view is on level store (organization hierarchy), product sales variant (item hierarchy) and day (time hierarchy). */
CREATE OR REPLACE VIEW fe_mstr_gf_lead.v_fact_retail_by_store_day_product_exchange_rate_type (
	country_org_sid COMMENT 'The unique identifier (surrogate key) for the country organization. This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'
	, country_org_cd COMMENT 'The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'
	, store_sid COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.'
	, prod_sid COMMENT 'The unique identifier (surrogate key) for the product.'
	, sales_variant_sid COMMENT 'The unique identifier (surrogate key) for the sales variant of a product.'
	, bus_year COMMENT 'Business year to which the measures are related'
	, cal_dt COMMENT 'The business date to which the measures are related.'
	, uom_cd COMMENT 'The code identifying the unit of measure for weight based products. (kg, ...)'
	, curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
	, curr_group_fg COMMENT 'Flag for group currency'
	, curr_local_fg COMMENT 'Flag for local currency'
	, exchange_rate_type_cd COMMENT 'The Exchange Rate Type Code'
	, exchange_bus_year COMMENT 'The Exchange Rate of the business year'
	/* Net turnover */
	, turnover_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, turnover_gross_val COMMENT 'The gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, sales_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	--, sales_gross_val COMMENT 'The sales portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, return_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	--, return_gross_val COMMENT 'The return portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, perf_adj_turnover_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'
	, perf_adj_sales_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'
	, perf_adj_return_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'
	, turnover_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, sales_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, return_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, perf_adj_turnover_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for business year-to-date.'
	/* Net turnover for previous year */
	, sales_py_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, return_py_net_val COMMENT 'The reurn portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, turnover_py_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, perf_adj_turnover_py_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous year.'
	, sales_py_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, return_py_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, turnover_py_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, perf_adj_turnover_py_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous business year-to-date.'
	, sales_py_swday_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, turnover_py_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, perf_adj_turnover_py_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year.'
	, sales_py_swday_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_py_swday_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, turnover_py_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, perf_adj_turnover_py_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year-to-date.'
	/* Net turnover for second to last year */
	, perf_adj_turnover_ppy_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last year.'
	, perf_adj_turnover_ppy_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last business year-to-date.'
	, perf_adj_turnover_ppy_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year.' 
	, perf_adj_turnover_ppy_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year-to-date.'
	/* Sales */
	, sales_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'
	, sales_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day.'
	, sales_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for business year-to-date.'
	, sales_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for business year-to-date.'
	/* Sales for previous year */
	, sales_py_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous year.'
	, sales_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous year.'
	, sales_py_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_swday_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	, sales_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Return */
	, return_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'
	, return_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day.'
	, return_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for business year-to-date.'
	, return_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for business year-to-date.'
	/* Return for previous year */
	, return_py_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous year.'
	, return_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous year.'
	, return_py_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, return_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, return_py_swday_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	/* Performance adjusted sales without specific price range */
	, perf_adj_sales_cnt COMMENT 'The number of sales variants which were sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_cnt COMMENT 'The number of sales variants which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_swday_cnt COMMENT 'The number of sales variants which were sold in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_sales_qty COMMENT 'The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_sales_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_sales_py_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_sales_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_sales_py_swday_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_sales_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	/* Performance adjusted returns without specific price range */
	, perf_adj_return_cnt COMMENT 'The number of sales variant which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_cnt COMMENT 'The number of sales variants which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_swday_cnt COMMENT 'The number of sales variants which were returned in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)' 
	, perf_adj_return_qty COMMENT 'The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_py_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_py_swday_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	/* Totals of sales and return */
	--, total_cnt COMMENT 'Total number of sales and returns'
	--, total_qty COMMENT 'Total quantity of sales and returns'
	/* Performance adjusted totals without specific price range */
	, perf_adj_total_cnt COMMENT 'Total number of sales and returns without specific price range.'
	, perf_adj_total_qty COMMENT 'Total quantity of sales and returns without specific price range.'
	, perf_adj_total_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for business year-to-date.'
	, perf_adj_total_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for business year-to-date.'
	, perf_adj_total_py_cnt COMMENT 'Total number of sales and returns without specific price range. This is for previous year.'
	, perf_adj_total_py_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for previous year.'
	, perf_adj_total_py_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_total_py_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_total_py_swday_cnt COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_total_py_swday_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_total_py_swday_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year-to-date.'
	, perf_adj_total_py_swday_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year-to-date.'
	, dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
	, dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
	, dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
	, dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
	) COMMENT = 'An aggregate fact holding gross and net turnover per day, product and store. Turnover amounts are taken from the cash register.' 
AS
SELECT r.country_org_sid AS country_org_sid
	, r.country_org_cd AS country_org_cd
	, r.store_sid AS store_sid
	, r.prod_sid AS prod_sid
	, r.sales_variant_sid AS sales_variant_sid
	, r.bus_year AS bus_year
	, r.bus_dt AS cal_dt
	, r.uom_cd AS uom_cd
	, e.src_curr_cd AS curr_cd
	, IFF(e.src_curr_cd = 'EUR', 1, 0) AS curr_group_fg
	, IFF(e.src_curr_cd = e.tgt_curr_cd, 1, 0) AS curr_local_fg
	, e.exchange_rate_type_cd AS exchange_rate_type_cd
	, e.bus_year AS exchange_bus_year
	/* Net turnover */
	, r.turnover_net_val / e.exchange_rate AS turnover_net_val
	, r.turnover_gross_val / e.exchange_rate AS turnover_gross_val
	, r.sales_net_val / e.exchange_rate AS sales_net_val
	--, r.sales_gross_val
	, r.return_net_val / e.exchange_rate AS return_net_val
	--, r.return_gross_val
	, r.perf_adj_turnover_net_val / e.exchange_rate AS perf_adj_turnover_net_val
	, r.perf_adj_sales_net_val / e.exchange_rate AS perf_adj_sales_net_val
	, r.perf_adj_return_net_val / e.exchange_rate AS perf_adj_return_net_val
	, r.turnover_bytd_net_val / e.exchange_rate AS turnover_bytd_net_val
	, r.sales_bytd_net_val / e.exchange_rate AS sales_bytd_net_val
	, r.return_bytd_net_val / e.exchange_rate AS return_bytd_net_val
	, r.perf_adj_turnover_bytd_net_val / e.exchange_rate AS perf_adj_turnover_bytd_net_val
	/* Net turnover for previous year */
	, r.sales_py_net_val / e.exchange_rate AS sales_py_net_val
	, r.return_py_net_val / e.exchange_rate AS return_py_net_val
	, r.turnover_py_net_val / e.exchange_rate AS turnover_py_net_val
	, r.perf_adj_turnover_py_net_val / e.exchange_rate AS perf_adj_turnover_py_net_val
	, r.sales_py_bytd_net_val / e.exchange_rate AS sales_py_bytd_net_val
	, r.return_py_bytd_net_val / e.exchange_rate AS return_py_bytd_net_val
	, r.turnover_py_bytd_net_val / e.exchange_rate AS turnover_py_bytd_net_val
	, r.perf_adj_turnover_py_bytd_net_val / e.exchange_rate AS perf_adj_turnover_py_bytd_net_val
	, r.sales_py_swday_net_val / e.exchange_rate AS sales_py_swday_net_val
	, r.return_py_swday_net_val / e.exchange_rate AS return_py_swday_net_val
	, r.turnover_py_swday_net_val / e.exchange_rate AS turnover_py_swday_net_val
	, r.perf_adj_turnover_py_swday_net_val / e.exchange_rate AS perf_adj_turnover_py_swday_net_val
	, r.sales_py_swday_bytd_net_val / e.exchange_rate AS sales_py_swday_bytd_net_val
	, r.return_py_swday_bytd_net_val / e.exchange_rate AS return_py_swday_bytd_net_val
	, r.turnover_py_swday_bytd_net_val / e.exchange_rate AS turnover_py_swday_bytd_net_val
	, r.perf_adj_turnover_py_swday_bytd_net_val / e.exchange_rate AS perf_adj_turnover_py_swday_bytd_net_val
	/* Net turnover for second to last year */
	, r.perf_adj_turnover_ppy_net_val / e.exchange_rate AS perf_adj_turnover_ppy_net_val
	, r.perf_adj_turnover_ppy_bytd_net_val / e.exchange_rate AS perf_adj_turnover_ppy_bytd_net_val
	, r.perf_adj_turnover_ppy_swday_net_val / e.exchange_rate AS perf_adj_turnover_ppy_swday_net_val
	, r.perf_adj_turnover_ppy_swday_bytd_net_val / e.exchange_rate AS perf_adj_turnover_ppy_swday_bytd_net_val
	/* Sales */
	, r.sales_cnt AS sales_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_qty * 0.453592 ELSE r.sales_qty END AS sales_qty
	, r.sales_bytd_cnt AS sales_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_bytd_qty * 0.453592 ELSE r.sales_bytd_qty END AS sales_bytd_qty	
	/* Sales for previous year */
	, r.sales_py_cnt AS sales_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_qty * 0.453592 ELSE r.sales_py_qty END AS sales_py_qty
	, r.sales_py_bytd_cnt AS sales_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_bytd_qty * 0.453592 ELSE r.sales_py_bytd_qty END AS sales_py_bytd_qty
	, r.sales_py_swday_cnt AS sales_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_swday_qty * 0.453592 ELSE r.sales_py_swday_qty END AS sales_py_swday_qty
	, r.sales_py_swday_bytd_cnt AS sales_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_swday_bytd_qty * 0.453592 ELSE r.sales_py_swday_bytd_qty END AS sales_py_swday_bytd_qty
	/* Return */
	, r.return_cnt AS return_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_qty * 0.453592 ELSE r.return_qty END AS return_qty
	, r.return_bytd_cnt AS return_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_bytd_qty * 0.453592 ELSE r.return_bytd_qty END AS return_bytd_qty
	/* Return for previous year */
	, r.return_py_cnt AS return_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_qty * 0.453592 ELSE r.return_py_qty END AS return_py_qty
	, r.return_py_bytd_cnt AS return_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_bytd_qty * 0.453592 ELSE r.return_py_bytd_qty END AS return_py_bytd_qty
	, r.return_py_swday_cnt AS return_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_swday_qty * 0.453592 ELSE r.return_py_swday_qty END AS return_py_swday_qty
	, r.return_py_swday_bytd_cnt AS return_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_swday_bytd_qty * 0.453592 ELSE r.return_py_swday_bytd_qty END AS return_py_swday_bytd_qty
	/* Performance adjusted sales without specific price range */
	, r.perf_adj_sales_cnt AS perf_adj_sales_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_qty * 0.453592 ELSE r.perf_adj_sales_qty END AS perf_adj_sales_qty
	, r.perf_adj_sales_bytd_cnt AS perf_adj_sales_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_bytd_qty * 0.453592 ELSE r.perf_adj_sales_bytd_qty END AS perf_adj_sales_bytd_qty
	, r.perf_adj_sales_py_cnt AS perf_adj_sales_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_py_qty * 0.453592 ELSE r.perf_adj_sales_py_qty END AS perf_adj_sales_py_qty
	, r.perf_adj_sales_py_bytd_cnt AS perf_adj_sales_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_py_bytd_qty * 0.453592 ELSE r.perf_adj_sales_py_bytd_qty END AS perf_adj_sales_py_bytd_qty
	, r.perf_adj_sales_py_swday_cnt AS perf_adj_sales_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_py_swday_qty * 0.453592 ELSE r.perf_adj_sales_py_swday_qty END AS perf_adj_sales_py_swday_qty
	, r.perf_adj_sales_py_swday_bytd_cnt AS perf_adj_sales_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_sales_py_swday_bytd_qty * 0.453592 ELSE r.perf_adj_sales_py_swday_bytd_qty END AS perf_adj_sales_py_swday_bytd_qty
	/* Performance adjusted returns without specific price range */
	, r.perf_adj_return_cnt AS perf_adj_return_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_qty * 0.453592 ELSE r.perf_adj_return_qty END AS perf_adj_return_qty
	, r.perf_adj_return_bytd_cnt AS perf_adj_return_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_bytd_qty * 0.453592 ELSE r.perf_adj_return_bytd_qty END AS perf_adj_return_bytd_qty
	, r.perf_adj_return_py_cnt AS perf_adj_return_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_py_qty * 0.453592 ELSE r.perf_adj_return_py_qty END AS perf_adj_return_py_qty
	, r.perf_adj_return_py_bytd_cnt AS perf_adj_return_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_py_bytd_qty * 0.453592 ELSE r.perf_adj_return_py_bytd_qty END AS perf_adj_return_py_bytd_qty
	, r.perf_adj_return_py_swday_cnt AS perf_adj_return_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_py_swday_qty * 0.453592 ELSE r.perf_adj_return_py_swday_qty END AS perf_adj_return_py_swday_qty
	, r.perf_adj_return_py_swday_bytd_cnt AS perf_adj_return_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_return_py_swday_bytd_qty * 0.453592 ELSE r.perf_adj_return_py_swday_bytd_qty END AS perf_adj_return_py_swday_bytd_qty
	/* Totals of sales and return */
	--, total_cnt COMMENT 'Total number of sales and returns'
	--, total_qty COMMENT 'Total quantity of sales and returns'
	/* Performance adjusted totals without specific price range */
	, r.perf_adj_total_cnt AS perf_adj_total_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_qty * 0.453592 ELSE r.perf_adj_total_qty END AS perf_adj_total_qty
	, r.perf_adj_total_bytd_cnt AS perf_adj_total_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_bytd_qty * 0.453592 ELSE r.perf_adj_total_bytd_qty END AS perf_adj_total_bytd_qty
	, r.perf_adj_total_py_cnt AS perf_adj_total_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_py_qty * 0.453592 ELSE r.perf_adj_total_py_qty END AS perf_adj_total_py_qty
	, r.perf_adj_total_py_bytd_cnt AS perf_adj_total_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_py_bytd_qty * 0.453592 ELSE r.perf_adj_total_py_bytd_qty END AS perf_adj_total_py_bytd_qty
	, r.perf_adj_total_py_swday_cnt AS perf_adj_total_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_py_swday_qty * 0.453592 ELSE r.perf_adj_total_py_swday_qty END AS perf_adj_total_py_swday_qty
	, r.perf_adj_total_py_swday_bytd_cnt AS perf_adj_total_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.perf_adj_total_py_swday_bytd_qty * 0.453592 ELSE r.perf_adj_total_py_swday_bytd_qty END AS perf_adj_total_py_swday_bytd_qty
	, r.dwh_created_tmsp AS dwh_created_tmsp
	, r.dwh_updated_tmsp AS dwh_updated_tmsp
	, r.dwh_load_id AS dwh_load_id
	, r.dwh_node_cd AS dwh_node_cd
FROM core_dim.v_fact_retail_by_store_day_product r
INNER JOIN core_dim.t_fact_exchange_rate e
	ON r.curr_cd = e.tgt_curr_cd
WHERE (e.src_curr_cd = 'EUR' 
	OR e.src_curr_cd = e.tgt_curr_cd
	)
;
