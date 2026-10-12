create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_RETAIL_BY_STORE_DAY_PRODUCT_EXCHANGE_RATE_TYPE_2(
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization. This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for the sales_2 variant of a product.',
	BUS_YEAR COMMENT 'Business year to which the measures are related',
	CAL_DT COMMENT 'The business date to which the measures are related.',
	UOM_CD COMMENT 'The code identifying the unit_2 of measure for weight based products. (kg, ...)',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for group currency',
	CURR_LOCAL_FG COMMENT 'Flag for local currency',
	EXCHANGE_RATE_TYPE_CD COMMENT 'The Exchange Rate Type Code',
	EXCHANGE_BUS_YEAR COMMENT 'The Exchange Rate of the business year',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	SALES_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	RETURN_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	PERF_ADJ_TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered.',
	PERF_ADJ_SALES_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)',
	PERF_ADJ_RETURN_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)',
	TURNOVER_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for business year-to-date.',
	SALES_BYTD_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for business year-to-date.',
	RETURN_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for business year-to-date.',
	PERF_ADJ_TURNOVER_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for business year-to-date.',
	SALES_PY_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous year.',
	RETURN_PY_NET_VAL COMMENT 'The reurn portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous year.',
	TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous year.',
	PERF_ADJ_TURNOVER_PY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for previous year.',
	SALES_PY_BYTD_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	TURNOVER_PY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for previous business year-to-date.',
	PERF_ADJ_TURNOVER_PY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for previous business year-to-date.',
	SALES_PY_SWDAY_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year.',
	PERF_ADJ_TURNOVER_PY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_NET_VAL COMMENT 'The sales_2 portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_PY_SWDAY_BYTD_NET_VAL COMMENT 'The return portion of the net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TURNOVER_PY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TURNOVER_PPY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for second to last year.',
	PERF_ADJ_TURNOVER_PPY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for second to last business year-to-date.',
	PERF_ADJ_TURNOVER_PPY_SWDAY_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year.',
	PERF_ADJ_TURNOVER_PPY_SWDAY_BYTD_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year-to-date.',
	SALES_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)',
	SALES_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day.',
	SALES_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for business year-to-date.',
	SALES_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for business year-to-date.',
	SALES_PY_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for previous year.',
	SALES_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for previous year.',
	SALES_PY_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for previous business year-to-date.',
	SALES_PY_SWDAY_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year.',
	SALES_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	SALES_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)',
	RETURN_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day.',
	RETURN_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for business year-to-date.',
	RETURN_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for business year-to-date.',
	RETURN_PY_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for previous year.',
	RETURN_PY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for previous year.',
	RETURN_PY_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for previous business year-to-date.',
	RETURN_PY_SWDAY_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year.',
	RETURN_PY_SWDAY_BYTD_CNT COMMENT 'The number of this sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	RETURN_PY_SWDAY_BYTD_QTY COMMENT 'In case of weight-based products, this is the quantity of the sales_2 variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.',
	PERF_ADJ_SALES_CNT COMMENT 'The number of sales_2 variants which were sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_CNT COMMENT 'The number of sales_2 variants which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_SWDAY_CNT COMMENT 'The number of sales_2 variants which were sold in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_SALES_QTY COMMENT 'The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_SALES_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_SALES_PY_QTY COMMENT 'The total quantity of weight-based products which were sold in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_SALES_PY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_SALES_PY_SWDAY_QTY COMMENT 'The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_CNT COMMENT 'The number of sales_2 variant which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_CNT COMMENT 'The number of sales_2 variants which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_SWDAY_CNT COMMENT 'The number of sales_2 variants which were returned in that store on the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT COMMENT 'The business-year-to-date sum of the number of sales_2 variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)',
	PERF_ADJ_RETURN_QTY COMMENT 'The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_PY_QTY COMMENT 'The total quantity of weight-based products which were returned in that store on the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_PY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar_2 date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_PY_SWDAY_QTY COMMENT 'The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY COMMENT 'The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)',
	PERF_ADJ_TOTAL_CNT COMMENT 'Total number of sales_2 and returns without specific price range.',
	PERF_ADJ_TOTAL_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range.',
	PERF_ADJ_TOTAL_BYTD_CNT COMMENT 'Total number of sales_2 and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TOTAL_BYTD_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for business year-to-date.',
	PERF_ADJ_TOTAL_PY_CNT COMMENT 'Total number of sales_2 and returns without specific price range. This is for previous year.',
	PERF_ADJ_TOTAL_PY_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for previous year.',
	PERF_ADJ_TOTAL_PY_BYTD_CNT COMMENT 'Total number of sales_2 and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_BYTD_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for previous business year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_CNT COMMENT 'Total number of sales_2 and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for same weekday of previous year.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT COMMENT 'Total number of sales_2 and returns without specific price range. This is for same weekday of previous year-to-date.',
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY COMMENT 'Total quantity of sales_2 and returns without specific price range. This is for same weekday of previous year-to-date.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as
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
	
	, r.turnover_net_val / e.exchange_rate AS turnover_net_val
	, r.turnover_gross_val / e.exchange_rate AS turnover_gross_val
	, r.sales_net_val / e.exchange_rate AS sales_net_val
	
	, r.return_net_val / e.exchange_rate AS return_net_val
	
	, r.perf_adj_turnover_net_val / e.exchange_rate AS perf_adj_turnover_net_val
	, r.perf_adj_sales_net_val / e.exchange_rate AS perf_adj_sales_net_val
	, r.perf_adj_return_net_val / e.exchange_rate AS perf_adj_return_net_val
	, r.turnover_bytd_net_val / e.exchange_rate AS turnover_bytd_net_val
	, r.sales_bytd_net_val / e.exchange_rate AS sales_bytd_net_val
	, r.return_bytd_net_val / e.exchange_rate AS return_bytd_net_val
	, r.perf_adj_turnover_bytd_net_val / e.exchange_rate AS perf_adj_turnover_bytd_net_val
	
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
	
	, r.perf_adj_turnover_ppy_net_val / e.exchange_rate AS perf_adj_turnover_ppy_net_val
	, r.perf_adj_turnover_ppy_bytd_net_val / e.exchange_rate AS perf_adj_turnover_ppy_bytd_net_val
	, r.perf_adj_turnover_ppy_swday_net_val / e.exchange_rate AS perf_adj_turnover_ppy_swday_net_val
	, r.perf_adj_turnover_ppy_swday_bytd_net_val / e.exchange_rate AS perf_adj_turnover_ppy_swday_bytd_net_val
	
	, r.sales_cnt AS sales_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_qty * 0.453592 ELSE r.sales_qty END AS sales_qty
	, r.sales_bytd_cnt AS sales_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_bytd_qty * 0.453592 ELSE r.sales_bytd_qty END AS sales_bytd_qty	
	
	, r.sales_py_cnt AS sales_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_qty * 0.453592 ELSE r.sales_py_qty END AS sales_py_qty
	, r.sales_py_bytd_cnt AS sales_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_bytd_qty * 0.453592 ELSE r.sales_py_bytd_qty END AS sales_py_bytd_qty
	, r.sales_py_swday_cnt AS sales_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_swday_qty * 0.453592 ELSE r.sales_py_swday_qty END AS sales_py_swday_qty
	, r.sales_py_swday_bytd_cnt AS sales_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.sales_py_swday_bytd_qty * 0.453592 ELSE r.sales_py_swday_bytd_qty END AS sales_py_swday_bytd_qty
	
	, r.return_cnt AS return_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_qty * 0.453592 ELSE r.return_qty END AS return_qty
	, r.return_bytd_cnt AS return_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_bytd_qty * 0.453592 ELSE r.return_bytd_qty END AS return_bytd_qty
	
	, r.return_py_cnt AS return_py_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_qty * 0.453592 ELSE r.return_py_qty END AS return_py_qty
	, r.return_py_bytd_cnt AS return_py_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_bytd_qty * 0.453592 ELSE r.return_py_bytd_qty END AS return_py_bytd_qty
	, r.return_py_swday_cnt AS return_py_swday_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_swday_qty * 0.453592 ELSE r.return_py_swday_qty END AS return_py_swday_qty
	, r.return_py_swday_bytd_cnt AS return_py_swday_bytd_cnt
	, CASE WHEN r.country_org_cd = 'US' THEN r.return_py_swday_bytd_qty * 0.453592 ELSE r.return_py_swday_bytd_qty END AS return_py_swday_bytd_qty
	
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
FROM core_dim.v_fact_retail_by_store_day_product_2 r
INNER JOIN core_dim.t_fact_exchange_rate_2 e
	ON r.curr_cd = e.tgt_curr_cd
WHERE (e.src_curr_cd = 'EUR' 
	OR e.src_curr_cd = e.tgt_curr_cd
	)
;