/* The data aggregation level for this view is on level store (organization hierarchy), product sales variant (item hierarchy) and day (time hierarchy). */
CREATE OR REPLACE VIEW core_dim.v_fact_retail_by_store_day_product (
	country_org_sid COMMENT 'The unique identifier (surrogate key) for the country organization. This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'
	, country_org_cd COMMENT 'The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'
	, store_sid COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.'
	, prod_sid COMMENT 'The unique identifier (surrogate key) for the product.'
	, sales_variant_sid COMMENT 'The unique identifier (surrogate key) for the sales variant of a product.'
	, bus_year COMMENT 'Business year to which the measures are related.'
	, bus_dt COMMENT 'The business date to which the measures are related.'
	, uom_cd COMMENT 'The code identifying the unit of measure for weight based products. (kg, ...)'
	, curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
	, sales_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'
	, sales_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day.'
	, return_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'
	, return_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day.'
	, total_cnt COMMENT 'Total number of sales and returns'
	, total_qty COMMENT 'Total quantity of sales and returns'
	, sales_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, return_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, sales_gross_val COMMENT 'The sales portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, return_gross_val COMMENT 'The return portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, turnover_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, turnover_gross_val COMMENT 'The gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'
	, perf_adj_sales_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'
	, perf_adj_sales_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'
	, perf_adj_sales_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'
	, perf_adj_return_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'
	, perf_adj_return_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'
	, perf_adj_return_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'
	, perf_adj_total_cnt COMMENT 'Total number of sales and returns without specific price range'
	, perf_adj_total_qty COMMENT 'Total quantity of sales and returns without specific price range'
	, perf_adj_turnover_net_val COMMENT 'Total of sales and return portion without specific price range'
	, sales_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for business year-to-date.'
	, sales_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for business year-to-date.'
	, return_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for business year-to-date.'
	, return_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for business year-to-date.'
	, sales_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, return_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, turnover_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'
	, perf_adj_sales_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_sales_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_return_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_return_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_total_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for business year-to-date.'
	, perf_adj_total_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for business year-to-date.'
	, perf_adj_turnover_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for business year-to-date.'
	, sales_py_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous year.'
	, sales_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous year.'
	, return_py_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous year.'
	, return_py_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous year.'
	, sales_py_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, return_py_net_val COMMENT 'The reurn portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, turnover_py_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'
	, perf_adj_sales_py_cnt COMMENT 'The number of sales variants which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_sales_py_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_return_py_cnt COMMENT 'The number of sales variants which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_return_py_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_total_py_cnt COMMENT 'Total number of sales and returns without specific price range. This is for previous year.'
	, perf_adj_total_py_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for previous year.'
	, perf_adj_turnover_py_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous year.'
	, sales_py_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'
	, return_py_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, return_py_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'
	, sales_py_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, return_py_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, turnover_py_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'
	, perf_adj_sales_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_sales_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_return_py_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_return_py_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_total_py_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_total_py_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for previous business year-to-date.'
	, perf_adj_turnover_py_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous business year-to-date.'
	, sales_py_swday_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'
	, sales_py_swday_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, return_py_swday_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, turnover_py_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'
	, perf_adj_sales_py_swday_cnt COMMENT 'The number of sales variants which were sold in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_sales_py_swday_qty COMMENT 'The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)' 
	, perf_adj_return_py_swday_cnt COMMENT 'The number of sales variants which were returned in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_return_py_swday_qty COMMENT 'The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_total_py_swday_cnt COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_total_py_swday_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year.'
	, perf_adj_turnover_py_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year.'
	, sales_py_swday_bytd_cnt COMMENT 'The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	, sales_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_py_swday_bytd_cnt COMMENT 'The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_py_swday_bytd_qty COMMENT 'In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'
	, sales_py_swday_bytd_net_val COMMENT 'The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, return_py_swday_bytd_net_val COMMENT 'The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, turnover_py_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'
	, perf_adj_sales_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_sales_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_return_py_swday_bytd_cnt COMMENT 'The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'
	, perf_adj_return_py_swday_bytd_qty COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'
	, perf_adj_total_py_swday_bytd_cnt COMMENT 'Total number of sales and returns without specific price range. This is for same weekday of previous year-to-date.'
	, perf_adj_total_py_swday_bytd_qty COMMENT 'Total quantity of sales and returns without specific price range. This is for same weekday of previous year-to-date.'
	, perf_adj_turnover_py_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year-to-date.'
	, perf_adj_turnover_ppy_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last year.'
	, perf_adj_turnover_ppy_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last business year-to-date.'
	, perf_adj_turnover_ppy_swday_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year.' 
	, perf_adj_turnover_ppy_swday_bytd_net_val COMMENT 'The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year-to-date.'
	, dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
	, dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
	, dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
	, dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
	) COMMENT = 'An aggregate fact holding basic retail measures per day, product and store. This includes sales and return volume and the gross and net turnover. Turnover amounts are taken from the cash register.'
AS 
WITH
/* Preselection of relevant time period */
limitation_time_period AS (
	SELECT cal_dt
		, bus_year
		--, cal_month
		, bus_year_offset 
		--, prev_1y_cal_dt
		--, prev_1y_swday_cal_dt
		--, prev_2y_cal_dt
		--, prev_2y_swday_cal_dt
	FROM core_dim.t_dim_calendar_date
	WHERE bus_year_offset BETWEEN -5 AND 0 -- last 5 business years and current business year 
	),
/* Preselection of corresponding days mapped for previous year values */
limitation_adjusted_days AS (
	SELECT cal_dt
		, cal_dt_adjust_type_cd
		, bus_year_diff
		, rel_cal_dt
	FROM core_rel.t_cal_date_adjusted_relationship
	JOIN limitation_time_period
		USING (cal_dt)
	-- Adjust types: M = previous year, MC = previous year by-to-date, W = previous year same weekday, WC = previous year same weekday by-to-date 
	),
/* Preselection of all fact data */ 
facts_retail AS (
	SELECT r.country_org_sid
		, r.country_org_cd
		, r.store_sid
		, r.prod_sid
		, r.sales_variant_sid
		, t.bus_year
		, r.bus_dt
		, r.uom_cd
		, r.curr_cd
		, r.sales_cnt
		, r.sales_qty
		, r.return_cnt
		, r.return_qty
		, r.cash_register_sales_net_val AS sales_net_val
		, r.cash_register_return_net_val AS return_net_val
		, r.cash_register_sales_gross_val AS sales_gross_val
		, r.cash_register_return_gross_val AS return_gross_val
		, r.perf_adj_sales_cnt
		, r.perf_adj_sales_qty
		, r.perf_adj_sales_net_val
		, r.perf_adj_return_cnt
		, r.perf_adj_return_qty
		, r.perf_adj_return_net_val
		, r.dwh_created_tmsp
		, r.dwh_updated_tmsp
		, r.dwh_load_id
		, r.dwh_node_cd
	FROM core_dim.t_fact_retail_by_store_day_product AS r -- PK (bus_dt, store_sid, sales_variant_sid)
	INNER JOIN limitation_time_period AS t
		ON r.bus_dt = t.cal_dt
	),
/* Cumulation of relevant facts per business year */ 
fact_cumulations AS (
	SELECT country_org_sid
		, country_org_cd
		, store_sid
		, prod_sid
		, sales_variant_sid
		, bus_year
		, bus_dt
		, uom_cd
		, curr_cd
		, sales_cnt
		, sales_qty
		, return_cnt
		, return_qty
		, ZEROIFNULL(sales_cnt) + ZEROIFNULL(return_cnt) AS total_cnt
		, ZEROIFNULL(sales_qty) + ZEROIFNULL(return_qty) AS total_qty
		, sales_net_val
		, return_net_val
		, sales_gross_val
		, return_gross_val
		, ZEROIFNULL(sales_net_val) + ZEROIFNULL(return_net_val) AS turnover_net_val
		, ZEROIFNULL(sales_gross_val) + ZEROIFNULL(return_gross_val) AS turnover_gross_val
		, perf_adj_sales_cnt
		, perf_adj_sales_qty
		, perf_adj_sales_net_val
		, perf_adj_return_cnt
		, perf_adj_return_qty
		, perf_adj_return_net_val
		, ZEROIFNULL(perf_adj_sales_cnt) + ZEROIFNULL(perf_adj_return_cnt) AS perf_adj_total_cnt
		, ZEROIFNULL(perf_adj_sales_qty) + ZEROIFNULL(perf_adj_return_qty) AS perf_adj_total_qty
		, ZEROIFNULL(perf_adj_sales_net_val) + ZEROIFNULL(perf_adj_return_net_val) AS perf_adj_turnover_net_val
		, SUM(sales_cnt) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS sales_bytd_cnt
		, SUM(sales_qty) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS sales_bytd_qty
		, SUM(return_cnt) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS return_bytd_cnt
		, SUM(return_qty) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS return_bytd_qty
		, SUM(sales_net_val) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS sales_bytd_net_val
		, SUM(return_net_val) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS return_bytd_net_val
		, SUM(turnover_net_val) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS turnover_bytd_net_val
		, SUM(perf_adj_sales_cnt) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_sales_bytd_cnt
		, SUM(perf_adj_sales_qty) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_sales_bytd_qty
		, SUM(perf_adj_return_cnt) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_return_bytd_cnt
		, SUM(perf_adj_return_qty) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_return_bytd_qty
		, SUM(perf_adj_total_cnt) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year 
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_total_bytd_cnt
		, SUM(perf_adj_total_qty) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_total_bytd_qty
		, SUM(perf_adj_turnover_net_val) OVER (
			PARTITION BY country_org_sid, store_sid, prod_sid, sales_variant_sid, bus_year
			ORDER BY bus_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS perf_adj_turnover_bytd_net_val
		, dwh_created_tmsp
		, dwh_updated_tmsp
		, dwh_load_id
		, dwh_node_cd
	FROM facts_retail
	),
/* Corresponding facts in the past 1/4 - for the calender day of previous business year */ 
facts_past_pc AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, d.cal_dt
		, d.rel_cal_dt
		/* KPI values for the same calendar day of previous business year */
		, c.sales_cnt 						AS sales_py_cnt
		, c.sales_qty 						AS sales_py_qty
		, c.return_cnt 						AS return_py_cnt
		, c.return_qty 						AS return_py_qty
		-- no total_cnt for py and no total_qty for py required
		, c.sales_net_val 					AS sales_py_net_val
		, c.return_net_val 					AS return_py_net_val
		, c.turnover_net_val 				AS turnover_py_net_val
		, c.perf_adj_sales_cnt				AS perf_adj_sales_py_cnt
		, c.perf_adj_sales_qty				AS perf_adj_sales_py_qty
		, c.perf_adj_return_cnt				AS perf_adj_return_py_cnt
		, c.perf_adj_return_qty				AS perf_adj_return_py_qty
		, c.perf_adj_total_cnt 				AS perf_adj_total_py_cnt
		, c.perf_adj_total_qty 				AS perf_adj_total_py_qty
		, c.perf_adj_turnover_net_val		AS perf_adj_turnover_py_net_val 
		/* bytd values */
		, c.sales_bytd_cnt 					AS sales_py_bytd_cnt
		, c.sales_bytd_qty 					AS sales_py_bytd_qty
		, c.return_bytd_cnt 				AS return_py_bytd_cnt
		, c.return_bytd_qty 				AS return_py_bytd_qty
		, c.sales_bytd_net_val 				AS sales_py_bytd_net_val
		, c.return_bytd_net_val 			AS return_py_bytd_net_val
		, c.turnover_bytd_net_val 			AS turnover_py_bytd_net_val
		, c.perf_adj_sales_bytd_cnt			AS perf_adj_sales_py_bytd_cnt
		, c.perf_adj_sales_bytd_qty			AS perf_adj_sales_py_bytd_qty
		, c.perf_adj_return_bytd_cnt		AS perf_adj_return_py_bytd_cnt
		, c.perf_adj_return_bytd_qty		AS perf_adj_return_py_bytd_qty		
		, c.perf_adj_total_bytd_cnt 		AS perf_adj_total_py_bytd_cnt
		, c.perf_adj_total_bytd_qty 		AS perf_adj_total_py_bytd_qty
		, c.perf_adj_turnover_bytd_net_val	AS perf_adj_turnover_py_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'M' -- calendar day 
			AND d.bus_year_diff = 1 -- previous year 
	),
/* Corresponding facts in the past 2/4 - for the same weekday of previous business year */ 
facts_past_pw AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, d.cal_dt
		, d.rel_cal_dt
		/* KPI values for the same weekday of previous business year */
		, c.sales_cnt 						AS sales_py_swday_cnt
		, c.sales_qty 						AS sales_py_swday_qty
		, c.return_cnt 						AS return_py_swday_cnt
		, c.return_qty 						AS return_py_swday_qty
		-- no total_cnt for py and no total_qty for py required
		, c.sales_net_val 					AS sales_py_swday_net_val
		, c.return_net_val 					AS return_py_swday_net_val
		, c.turnover_net_val 				AS turnover_py_swday_net_val
		, c.perf_adj_sales_cnt				AS perf_adj_sales_py_swday_cnt
		, c.perf_adj_sales_qty				AS perf_adj_sales_py_swday_qty
		, c.perf_adj_return_cnt				AS perf_adj_return_py_swday_cnt
		, c.perf_adj_return_qty				AS perf_adj_return_py_swday_qty
		, c.perf_adj_total_cnt 				AS perf_adj_total_py_swday_cnt
		, c.perf_adj_total_qty 				AS perf_adj_total_py_swday_qty
		, c.perf_adj_turnover_net_val		AS perf_adj_turnover_py_swday_net_val 
		/* bytd values */
		, c.sales_bytd_cnt 					AS sales_py_swday_bytd_cnt
		, c.sales_bytd_qty 					AS sales_py_swday_bytd_qty
		, c.return_bytd_cnt 				AS return_py_swday_bytd_cnt
		, c.return_bytd_qty 				AS return_py_swday_bytd_qty
		, c.sales_bytd_net_val 				AS sales_py_swday_bytd_net_val
		, c.return_bytd_net_val 			AS return_py_swday_bytd_net_val
		, c.turnover_bytd_net_val 			AS turnover_py_swday_bytd_net_val
		, c.perf_adj_sales_bytd_cnt			AS perf_adj_sales_py_swday_bytd_cnt
		, c.perf_adj_sales_bytd_qty			AS perf_adj_sales_py_swday_bytd_qty
		, c.perf_adj_return_bytd_cnt		AS perf_adj_return_py_swday_bytd_cnt
		, c.perf_adj_return_bytd_qty		AS perf_adj_return_py_swday_bytd_qty
		, c.perf_adj_total_bytd_cnt 		AS perf_adj_total_py_swday_bytd_cnt
		, c.perf_adj_total_bytd_qty 		AS perf_adj_total_py_swday_bytd_qty
		, c.perf_adj_turnover_bytd_net_val	AS perf_adj_turnover_py_swday_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'W' -- weekday 
			AND d.bus_year_diff = 1 -- previous year 
	),
/* Corresponding facts in the past 3/4 - for the same calendar day of second to last business year */ 
facts_past_ppc AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, d.cal_dt
		, d.rel_cal_dt
		/* KPI values for the same calendar day of second to last business year */
		, c.perf_adj_turnover_net_val			AS perf_adj_turnover_ppy_net_val 
		, c.perf_adj_turnover_bytd_net_val		AS perf_adj_turnover_ppy_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'M' -- calendar day 
			AND d.bus_year_diff = 2 -- second to last business year 
	),
/* Corresponding facts in the past 4/4 - for the same weekday of second to last business year */ 
facts_past_ppw AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, d.cal_dt
		, d.rel_cal_dt
		/* KPI values for the same weekday of second to last business year */
		, c.perf_adj_turnover_net_val			AS perf_adj_turnover_ppy_swday_net_val 
		, c.perf_adj_turnover_bytd_net_val		AS perf_adj_turnover_ppy_swday_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'W' -- weekday 
			AND d.bus_year_diff = 2 -- second to last business year 
	),
/* Mapping of facts from previous business years for each calendar day and weekday */ 
fact_consolidation AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, c.bus_year
		, c.bus_dt
		, c.uom_cd
		, c.curr_cd
		, c.sales_cnt
		, c.sales_qty
		, c.return_cnt
		, c.return_qty
		, c.total_cnt
		, c.total_qty
		, c.sales_net_val
		, c.return_net_val
		, c.sales_gross_val
		, c.return_gross_val
		, c.turnover_net_val
		, c.turnover_gross_val
		, c.perf_adj_sales_cnt
		, c.perf_adj_sales_qty
		, c.perf_adj_sales_net_val
		, c.perf_adj_return_cnt
		, c.perf_adj_return_qty
		, c.perf_adj_return_net_val
		, c.perf_adj_total_cnt
		, c.perf_adj_total_qty
		, c.perf_adj_turnover_net_val
		, c.sales_bytd_cnt
		, c.sales_bytd_qty
		, c.return_bytd_cnt
		, c.return_bytd_qty
		, c.sales_bytd_net_val
		, c.return_bytd_net_val
		, c.turnover_bytd_net_val
		, c.perf_adj_sales_bytd_cnt
		, c.perf_adj_sales_bytd_qty
		, c.perf_adj_return_bytd_cnt
		, c.perf_adj_return_bytd_qty
		, c.perf_adj_total_bytd_cnt
		, c.perf_adj_total_bytd_qty
		, c.perf_adj_turnover_bytd_net_val
		/* KPI values for the same calendar day of previous business year */
		, pc.rel_cal_dt AS rel_cal_dt_pc 
		, pc.sales_py_cnt
		, pc.sales_py_qty
		, pc.return_py_cnt
		, pc.return_py_qty
		-- no total_cnt for py and no total_qty for py required
		, pc.sales_py_net_val
		, pc.return_py_net_val
		, pc.turnover_py_net_val
		, pc.perf_adj_sales_py_cnt
		, pc.perf_adj_sales_py_qty
		, pc.perf_adj_return_py_cnt
		, pc.perf_adj_return_py_qty
		, pc.perf_adj_total_py_cnt
		, pc.perf_adj_total_py_qty
		, pc.perf_adj_turnover_py_net_val 
		/* bytd values */
		, pc.sales_py_bytd_cnt
		, pc.sales_py_bytd_qty
		, pc.return_py_bytd_cnt
		, pc.return_py_bytd_qty
		, pc.sales_py_bytd_net_val
		, pc.return_py_bytd_net_val
		, pc.turnover_py_bytd_net_val
		, pc.perf_adj_sales_py_bytd_cnt
		, pc.perf_adj_sales_py_bytd_qty
		, pc.perf_adj_return_py_bytd_cnt
		, pc.perf_adj_return_py_bytd_qty
		, pc.perf_adj_total_py_bytd_cnt
		, pc.perf_adj_total_py_bytd_qty
		, pc.perf_adj_turnover_py_bytd_net_val
		/* KPI values for the same weekday of previous business year */
		, pw.rel_cal_dt AS rel_cal_dt_pw 
		, pw.sales_py_swday_cnt
		, pw.sales_py_swday_qty
		, pw.return_py_swday_cnt
		, pw.return_py_swday_qty
		-- no total_cnt for py and no total_qty for py required
		, pw.sales_py_swday_net_val
		, pw.return_py_swday_net_val
		, pw.turnover_py_swday_net_val
		, pw.perf_adj_sales_py_swday_cnt
		, pw.perf_adj_sales_py_swday_qty
		, pw.perf_adj_return_py_swday_cnt
		, pw.perf_adj_return_py_swday_qty
		, pw.perf_adj_total_py_swday_cnt
		, pw.perf_adj_total_py_swday_qty
		, pw.perf_adj_turnover_py_swday_net_val 
		/* bytd values */
		, pw.sales_py_swday_bytd_cnt
		, pw.sales_py_swday_bytd_qty
		, pw.return_py_swday_bytd_cnt
		, pw.return_py_swday_bytd_qty
		, pw.sales_py_swday_bytd_net_val
		, pw.return_py_swday_bytd_net_val
		, pw.turnover_py_swday_bytd_net_val
		, pw.perf_adj_sales_py_swday_bytd_cnt
		, pw.perf_adj_sales_py_swday_bytd_qty
		, pw.perf_adj_return_py_swday_bytd_cnt
		, pw.perf_adj_return_py_swday_bytd_qty
		, pw.perf_adj_total_py_swday_bytd_cnt
		, pw.perf_adj_total_py_swday_bytd_qty
		, pw.perf_adj_turnover_py_swday_bytd_net_val
		/* KPI values for the same calendar day of second to last business year */
		, ppc.rel_cal_dt AS rel_cal_dt_ppc
		, ppc.perf_adj_turnover_ppy_net_val 
		, ppc.perf_adj_turnover_ppy_bytd_net_val
		/* KPI values for the same weekday of second to last business year */
		, ppw.rel_cal_dt AS rel_cal_dt_ppw
		, ppw.perf_adj_turnover_ppy_swday_net_val 
		, ppw.perf_adj_turnover_ppy_swday_bytd_net_val
		, c.dwh_created_tmsp
		, c.dwh_updated_tmsp
		, c.dwh_load_id
		, c.dwh_node_cd
	FROM fact_cumulations c 
	LEFT OUTER JOIN facts_past_pc pc
		ON c.store_sid = pc.store_sid -- no need for country_org_sid due to PK 
			AND c.sales_variant_sid = pc.sales_variant_sid -- no need for prod_sid due to PK 
			AND c.bus_dt = pc.cal_dt
	LEFT OUTER JOIN facts_past_pw pw
		ON c.store_sid = pw.store_sid -- no need for country_org_sid due to PK 
			AND c.sales_variant_sid = pw.sales_variant_sid -- no need for prod_sid due to PK 
			AND c.bus_dt = pw.cal_dt
	LEFT OUTER JOIN facts_past_ppc ppc
		ON c.store_sid = ppc.store_sid -- no need for country_org_sid due to PK 
			AND c.sales_variant_sid = ppc.sales_variant_sid -- no need for prod_sid due to PK 
			AND c.bus_dt = ppc.cal_dt
	LEFT OUTER JOIN facts_past_ppw ppw
		ON c.store_sid = ppw.store_sid -- no need for country_org_sid due to PK 
			AND c.sales_variant_sid = ppw.sales_variant_sid -- no need for prod_sid due to PK 
			AND c.bus_dt = ppw.cal_dt
	)
/* Final select */
SELECT country_org_sid
	, country_org_cd
	, store_sid
	, prod_sid
	, sales_variant_sid
	, bus_year
	, bus_dt
	, uom_cd
	, curr_cd
	, sales_cnt
	, sales_qty
	, return_cnt
	, return_qty
	, total_cnt
	, total_qty
	, sales_net_val
	, return_net_val
	, sales_gross_val
	, return_gross_val
	, turnover_net_val
	, turnover_gross_val
	, perf_adj_sales_cnt
	, perf_adj_sales_qty
	, perf_adj_sales_net_val
	, perf_adj_return_cnt
	, perf_adj_return_qty
	, perf_adj_return_net_val
	, perf_adj_total_cnt
	, perf_adj_total_qty
	, perf_adj_turnover_net_val
	, sales_bytd_cnt
	, sales_bytd_qty
	, return_bytd_cnt
	, return_bytd_qty
	, sales_bytd_net_val
	, return_bytd_net_val
	, turnover_bytd_net_val
	, perf_adj_sales_bytd_cnt
	, perf_adj_sales_bytd_qty
	, perf_adj_return_bytd_cnt
	, perf_adj_return_bytd_qty
	, perf_adj_total_bytd_cnt
	, perf_adj_total_bytd_qty
	, perf_adj_turnover_bytd_net_val
	/* KPI values for the same calendar day of previous business year */
	--, rel_cal_dt_pc
	, sales_py_cnt
	, sales_py_qty
	, return_py_cnt
	, return_py_qty
	-- no total_cnt for py and no total_qty for py required
	, sales_py_net_val
	, return_py_net_val
	, turnover_py_net_val
	, perf_adj_sales_py_cnt
	, perf_adj_sales_py_qty
	, perf_adj_return_py_cnt
	, perf_adj_return_py_qty
	, perf_adj_total_py_cnt
	, perf_adj_total_py_qty
	, perf_adj_turnover_py_net_val 
	/* bytd values */
	, sales_py_bytd_cnt
	, sales_py_bytd_qty
	, return_py_bytd_cnt
	, return_py_bytd_qty
	, sales_py_bytd_net_val
	, return_py_bytd_net_val
	, turnover_py_bytd_net_val
	, perf_adj_sales_py_bytd_cnt
	, perf_adj_sales_py_bytd_qty
	, perf_adj_return_py_bytd_cnt
	, perf_adj_return_py_bytd_qty
	, perf_adj_total_py_bytd_cnt
	, perf_adj_total_py_bytd_qty
	, perf_adj_turnover_py_bytd_net_val
	/* KPI values for the same weekday of previous business year */
	--, rel_cal_dt_pw
	, sales_py_swday_cnt
	, sales_py_swday_qty
	, return_py_swday_cnt
	, return_py_swday_qty
	-- no total_cnt for py and no total_qty for py required
	, sales_py_swday_net_val
	, return_py_swday_net_val
	, turnover_py_swday_net_val
	, perf_adj_sales_py_swday_cnt
	, perf_adj_sales_py_swday_qty
	, perf_adj_return_py_swday_cnt
	, perf_adj_return_py_swday_qty
	, perf_adj_total_py_swday_cnt
	, perf_adj_total_py_swday_qty
	, perf_adj_turnover_py_swday_net_val 
	/* bytd values */
	, sales_py_swday_bytd_cnt
	, sales_py_swday_bytd_qty
	, return_py_swday_bytd_cnt
	, return_py_swday_bytd_qty
	, sales_py_swday_bytd_net_val
	, return_py_swday_bytd_net_val
	, turnover_py_swday_bytd_net_val
	, perf_adj_sales_py_swday_bytd_cnt
	, perf_adj_sales_py_swday_bytd_qty
	, perf_adj_return_py_swday_bytd_cnt
	, perf_adj_return_py_swday_bytd_qty
	, perf_adj_total_py_swday_bytd_cnt
	, perf_adj_total_py_swday_bytd_qty
	, perf_adj_turnover_py_swday_bytd_net_val
	/* KPI values for the same calendar day of second to last business year */
	--, rel_cal_dt_ppc
	, perf_adj_turnover_ppy_net_val 
	, perf_adj_turnover_ppy_bytd_net_val
	/* KPI values for the same weekday of second to last business year */
	--, rel_cal_dt_ppw
	, perf_adj_turnover_ppy_swday_net_val 
	, perf_adj_turnover_ppy_swday_bytd_net_val
	, dwh_created_tmsp
	, dwh_updated_tmsp
	, dwh_load_id
	, dwh_node_cd
FROM fact_consolidation
--ORDER BY country_org_cd 
--	, store_sid
--	, prod_sid
--	, sales_variant_sid
--	, bus_year
--	, bus_dt
;
