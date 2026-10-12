create or replace view LDL_DATA_PRODUCTION.EVAL.V_FACT_RETAIL_BY_STORE_DAY_PRODUCT_1(
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_1 organization. This is on the one hand related to the country_1 organization which is responsible for the store which has sold the product, and on the other hand to the country_1 organization which has defined the local properties of the product.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.) This is on the one hand related to the country_1 organization which is responsible for the store which has sold the product, and on the other hand to the country_1 organization which has defined the local properties of the product.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for the sales_1 variant of a product.',
	BUS_YEAR COMMENT 'Business year to which the measures are related.',
	BUS_DT COMMENT 'The business date to which the measures are related.',
	UOM_CD COMMENT 'The code identifying the unit_1 of measure for weight based products. (kg, ...)',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	SALES_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)',
	SALES_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day.',
	RETURN_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)',
	RETURN_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day.',
	TOTAL_CNT COMMENT 'Total number of sales_1 and returns',
	TOTAL_QTY COMMENT 'Total quantity of sales_1 and returns',
	SALES_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	RETURN_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	SALES_GROSS_VAL COMMENT 'The sales_1 portion of the gross turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	RETURN_GROSS_VAL COMMENT 'The return portion of the gross turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	PERF_ADJ_SALES_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)',
	PERF_ADJ_SALES_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered.',
	PERF_ADJ_SALES_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)',
	PERF_ADJ_RETURN_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)',
	PERF_ADJ_RETURN_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered.',
	PERF_ADJ_RETURN_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)',
	PERF_ADJ_TOTAL_CNT COMMENT 'Total number of sales_1 and returns without specific price range',
	PERF_ADJ_TOTAL_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range',
	PERF_ADJ_TURNOVER_NET_VAL COMMENT 'Total of sales_1 and return portion without specific price range',
	SALES_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. This is for business year-to-date.',
	SALES_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. This is for business year-to-date.',
	RETURN_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. This is for business year-to-date.',
	RETURN_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. This is for business year-to-date.',
	SALES_BYTD_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for business year-to-date.',
	RETURN_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for business year-to-date.',
	TURNOVER_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for business year-to-date.',
	PERF_ADJ_TOTAL_BYTD_CNT COMMENT 'Total number of sales_1 and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TOTAL_BYTD_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TURNOVER_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for business year-to-date.',
	SALES_PY_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. This is for previous year.',
	SALES_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. This is for previous year.',
	RETURN_PY_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. This is for previous year.',
	RETURN_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. This is for previous year.',
	SALES_PY_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous year.',
	RETURN_PY_NET_VAL COMMENT 'The reurn portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous year.',
	TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous year.',
	PERF_ADJ_TOTAL_PY_CNT COMMENT 'Total number of sales_1 and returns without specific price range. This is for previous year.',
	PERF_ADJ_TOTAL_PY_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range. This is for previous year.',
	PERF_ADJ_TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for previous year.',
	SALES_PY_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_BYTD_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	TURNOVER_PY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_BYTD_CNT COMMENT 'Total number of sales_1 and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_BYTD_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TURNOVER_PY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for previous business year-to-date.',
	SALES_PY_SWDAY_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_CNT COMMENT 'Total number of sales_1 and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	SALES_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales_1 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	SALES_PY_SWDAY_BYTD_NET_VAL COMMENT 'The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_PY_SWDAY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT COMMENT 'Total number of sales_1 and returns without specific price range. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY COMMENT 'Total quantity of sales_1 and returns without specific price range. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TURNOVER_PPY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for second to last year.',
	PERF_ADJ_TURNOVER_PPY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for second to last business year-to-date.',
	PERF_ADJ_TURNOVER_PPY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year.',
	PERF_ADJ_TURNOVER_PPY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_1 variant of the product in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year-to-date.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='An aggregate fact holding basic retail measures per day, product and store. This includes sales_1 and return volume and the gross and net turnover. Turnover amounts are taken from the cash register.'
 as 
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
	FROM core_dim.t_dim_calendar_date_1
	WHERE bus_year_offset BETWEEN -3 AND 0 -- last 3 business years and current business year 
	),
/* Preselection of corresponding days mapped for previous year values */
limitation_adjusted_days AS (
	SELECT cal_dt
		, cal_dt_adjust_type_cd
		, bus_year_diff
		, rel_cal_dt
	FROM core_rel.t_cal_date_adjusted_relationship_1
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
	FROM core_dim.t_fact_retail_by_store_day_product_1 AS r -- PK (bus_dt, store_sid, sales_variant_sid)
	INNER JOIN limitation_time_period AS t
		ON r.bus_dt = t.cal_dt
	WHERE country_org_sid = 127 --BE  -- THIS IS FOR TESTING!!!!!
--		AND store_sid = 5417 --BE  -- THIS IS FOR TESTING!!!!!
--		AND prod_sid = 483794 -- Wird jeden TAG_1 verkauf  -- THIS IS FOR TESTING!!!!!
		AND (cal_dt BETWEEN '2025-01-01' AND '2025-01-31' -- THIS IS FOR TESTING!!!!!
			OR cal_dt BETWEEN '2024-01-01' AND '2024-01-31' -- THIS IS FOR TESTING!!!!!
			OR cal_dt BETWEEN '2023-01-01' AND '2023-01-31' -- THIS IS FOR TESTING!!!!!
			)
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
		/* KPI values for the same calendar_1 day of previous business year */
		, c.sales_cnt 						AS sales_py_cnt
		, c.sales_qty 						AS sales_py_qty
		, c.return_cnt 						AS return_py_cnt
		, c.return_qty 						AS return_py_qty
		-- no total_cnt for py and no total_qty for py required
		, c.sales_net_val 					AS sales_py_net_val
		, c.return_net_val 					AS return_py_net_val
		, c.turnover_net_val 				AS turnover_py_net_val
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
		, c.perf_adj_total_bytd_cnt 		AS perf_adj_total_py_bytd_cnt
		, c.perf_adj_total_bytd_qty 		AS perf_adj_total_py_bytd_qty
		, c.perf_adj_turnover_bytd_net_val	AS perf_adj_turnover_py_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'M' -- calendar_1 day 
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
		, c.perf_adj_total_bytd_cnt 		AS perf_adj_total_py_swday_bytd_cnt
		, c.perf_adj_total_bytd_qty 		AS perf_adj_total_py_swday_bytd_qty
		, c.perf_adj_turnover_bytd_net_val	AS perf_adj_turnover_py_swday_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'W' -- weekday 
			AND d.bus_year_diff = 1 -- previous year 
	),
/* Corresponding facts in the past 3/4 - for the same calendar_1 day of second to last business year */ 
facts_past_ppc AS (
	SELECT c.country_org_sid
		, c.country_org_cd
		, c.store_sid
		, c.prod_sid
		, c.sales_variant_sid
		, d.cal_dt
		, d.rel_cal_dt
		/* KPI values for the same calendar_1 day of second to last business year */
		, c.perf_adj_turnover_net_val			AS perf_adj_turnover_ppy_net_val 
		, c.perf_adj_turnover_bytd_net_val		AS perf_adj_turnover_ppy_bytd_net_val
	FROM fact_cumulations c
	JOIN limitation_adjusted_days d
		ON c.bus_dt = d.rel_cal_dt
			AND d.cal_dt_adjust_type_cd = 'M' -- calendar_1 day 
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
/* Mapping of facts from previous business years for each calendar_1 day and weekday */ 
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
		, c.perf_adj_total_bytd_cnt
		, c.perf_adj_total_bytd_qty
		, c.perf_adj_turnover_bytd_net_val
		/* KPI values for the same calendar_1 day of previous business year */
		, pc.rel_cal_dt AS rel_cal_dt_pc 
		, pc.sales_py_cnt
		, pc.sales_py_qty
		, pc.return_py_cnt
		, pc.return_py_qty
		-- no total_cnt for py and no total_qty for py required
		, pc.sales_py_net_val
		, pc.return_py_net_val
		, pc.turnover_py_net_val
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
		, pw.perf_adj_total_py_swday_bytd_cnt
		, pw.perf_adj_total_py_swday_bytd_qty
		, pw.perf_adj_turnover_py_swday_bytd_net_val
		/* KPI values for the same calendar_1 day of second to last business year */
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
	, perf_adj_total_bytd_cnt
	, perf_adj_total_bytd_qty
	, perf_adj_turnover_bytd_net_val
	/* KPI values for the same calendar_1 day of previous business year */
	--, rel_cal_dt_pc
	, sales_py_cnt
	, sales_py_qty
	, return_py_cnt
	, return_py_qty
	-- no total_cnt for py and no total_qty for py required
	, sales_py_net_val
	, return_py_net_val
	, turnover_py_net_val
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
	, perf_adj_total_py_swday_bytd_cnt
	, perf_adj_total_py_swday_bytd_qty
	, perf_adj_turnover_py_swday_bytd_net_val
	/* KPI values for the same calendar_1 day of second to last business year */
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