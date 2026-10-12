/* The data aggregation level for this view based on the source view is on level store (organization hierarchy), product sales variant (item hierarchy) and day (time hierarchy). */


CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_retail_by_store_day_product (country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country organization. This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'),
country_org_cd
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'),
store_sid OPTIONS(description='The unique identifier (surrogate key) for the store, which has generated the revenue.'),
prod_sid OPTIONS(description='The unique identifier (surrogate key) for the product.'), sales_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for the sales variant of a product.'), bus_year
OPTIONS(description='Business year to which the measures are related'), cal_dt
OPTIONS(description='The business date to which the measures are related.'), uom_cd
OPTIONS(description='The code identifying the unit of measure for weight based products. (kg, ...)'), curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for group currency'), curr_local_fg OPTIONS(description='Flag for local currency'),
turnover_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
turnover_gross_val
OPTIONS(description='The gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
sales_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
return_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
perf_adj_turnover_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'),
perf_adj_sales_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
turnover_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'),
sales_bytd_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'),
return_bytd_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for business year-to-date.'),
perf_adj_turnover_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for business year-to-date.'),
sales_py_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'),
return_py_net_val
OPTIONS(description='The reurn portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'),
turnover_py_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous year.'),
perf_adj_turnover_py_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous year.'),
sales_py_bytd_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'),
return_py_bytd_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'),
turnover_py_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for previous business year-to-date.'),
perf_adj_turnover_py_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for previous business year-to-date.'),
sales_py_swday_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'),
return_py_swday_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'),
turnover_py_swday_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year.'),
perf_adj_turnover_py_swday_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year.'),
sales_py_swday_bytd_net_val
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'),
return_py_swday_bytd_net_val
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'),
turnover_py_swday_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. This is for same weekday of previous year-to-date.'),
perf_adj_turnover_py_swday_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of previous year-to-date.'),
perf_adj_turnover_ppy_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last year.'),
perf_adj_turnover_ppy_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for second to last business year-to-date.'),
perf_adj_turnover_ppy_swday_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year.'),
perf_adj_turnover_ppy_swday_bytd_net_val
OPTIONS(description='The net turnover which was generated for this sales variant of the product in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. This is for same weekday of second to last year-to-date.'),
sales_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'),
sales_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day.'),
sales_bytd_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. This is for business year-to-date.'),
sales_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for business year-to-date.'),
sales_py_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. This is for previous year.'),
sales_py_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous year.'),
sales_py_bytd_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'),
sales_py_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for previous business year-to-date.'),
sales_py_swday_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'),
sales_py_swday_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year.'),
sales_py_swday_bytd_cnt
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'),
sales_py_swday_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. This is for same weekday of previous year-to-date.'),
return_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'),
return_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day.'),
return_bytd_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. This is for business year-to-date.'),
return_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for business year-to-date.'),
return_py_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. This is for previous year.'),
return_py_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous year.'),
return_py_bytd_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'),
return_py_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for previous business year-to-date.'),
return_py_swday_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'),
return_py_swday_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year.'),
return_py_swday_bytd_cnt
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'),
return_py_swday_bytd_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. This is for same weekday of previous year-to-date.'),
perf_adj_sales_cnt
OPTIONS(description='The number of sales variants which were sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_cnt
OPTIONS(description='The number of sales variants which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_cnt
OPTIONS(description='The number of sales variants which were sold in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_py_swday_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_sales_qty
OPTIONS(description='The total quantity of weight-based products which have been sold in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_sales_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_sales_py_qty
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_sales_py_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been sold in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_sales_py_swday_qty
OPTIONS(description='The total quantity of weight-based products which were sold in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_sales_py_swday_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been sold in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_cnt
OPTIONS(description='The number of sales variant which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_cnt
OPTIONS(description='The number of sales variants which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_cnt
OPTIONS(description='The number of sales variants which were returned in that store on the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_py_swday_bytd_cnt
OPTIONS(description='The business-year-to-date sum of the number of sales variants which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Weight-based products are not included.)'),
perf_adj_return_qty
OPTIONS(description='The total quantiy of weight-based products which were returned in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_py_qty
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_py_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products which have been returned in that store up to the same calendar date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_py_swday_qty
OPTIONS(description='The total quantity of weight-based products which were returned in that store on the same weekday date one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_return_py_swday_bytd_qty
OPTIONS(description='The business-year-to-date sum of the quantity of weight-based products  which have been returned in that store up to the same weekday one year ago. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit defined by the unit of measure code)'),
perf_adj_total_cnt OPTIONS(description='Total number of sales and returns without specific price range.'),
perf_adj_total_qty OPTIONS(description='Total quantity of sales and returns without specific price range.'),
perf_adj_total_bytd_cnt
OPTIONS(description='Total number of sales and returns without specific price range. This is for business year-to-date.'),
perf_adj_total_bytd_qty
OPTIONS(description='Total quantity of sales and returns without specific price range. This is for business year-to-date.'),
perf_adj_total_py_cnt
OPTIONS(description='Total number of sales and returns without specific price range. This is for previous year.'),
perf_adj_total_py_qty
OPTIONS(description='Total quantity of sales and returns without specific price range. This is for previous year.'),
perf_adj_total_py_bytd_cnt
OPTIONS(description='Total number of sales and returns without specific price range. This is for previous business year-to-date.'),
perf_adj_total_py_bytd_qty
OPTIONS(description='Total quantity of sales and returns without specific price range. This is for previous business year-to-date.'),
perf_adj_total_py_swday_cnt
OPTIONS(description='Total number of sales and returns without specific price range. This is for same weekday of previous year.'),
perf_adj_total_py_swday_qty
OPTIONS(description='Total quantity of sales and returns without specific price range. This is for same weekday of previous year.'),
perf_adj_total_py_swday_bytd_cnt
OPTIONS(description='Total number of sales and returns without specific price range. This is for same weekday of previous year-to-date.'),
perf_adj_total_py_swday_bytd_qty
OPTIONS(description='Total quantity of sales and returns without specific price range. This is for same weekday of previous year-to-date.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `AN AGGREGATE FACT HOLDING GROSS AND NET TURNOVER PER DAY, PRODUCT AND STORE. TURNOVER AMOUNTS ARE TAKEN FROM THE CASH REGISTER.`)
AS SELECT R.country_org_sid,
 R.country_org_cd,
 R.store_sid,
 R.prod_sid,
 R.sales_variant_sid,
 R.bus_year,
 R.bus_dt AS cal_dt,
 R.uom_cd,
 E.src_curr_cd AS curr_cd,
 IF(E.src_curr_cd = 'EUR', 1, 0) AS curr_group_fg,
 IF(E.src_curr_cd = E.tgt_curr_cd, 1, 0) AS curr_local_fg,
  R.turnover_net_val / E.exchange_rate AS turnover_net_val,
  R.turnover_gross_val / E.exchange_rate AS turnover_gross_val,
  R.sales_net_val / E.exchange_rate AS sales_net_val,
  R.return_net_val / E.exchange_rate AS return_net_val,
  R.perf_adj_turnover_net_val / E.exchange_rate AS perf_adj_turnover_net_val,
  R.perf_adj_sales_net_val / E.exchange_rate AS perf_adj_sales_net_val,
  R.perf_adj_return_net_val / E.exchange_rate AS perf_adj_return_net_val,
  R.turnover_bytd_net_val / E.exchange_rate AS turnover_bytd_net_val,
  R.sales_bytd_net_val / E.exchange_rate AS sales_bytd_net_val,
  R.return_bytd_net_val / E.exchange_rate AS return_bytd_net_val,
  R.perf_adj_turnover_bytd_net_val / E.exchange_rate AS perf_adj_turnover_bytd_net_val,
  R.sales_py_net_val / E.exchange_rate AS sales_py_net_val,
  R.return_py_net_val / E.exchange_rate AS return_py_net_val,
  R.turnover_py_net_val / E.exchange_rate AS turnover_py_net_val,
  R.perf_adj_turnover_py_net_val / E.exchange_rate AS perf_adj_turnover_py_net_val,
  R.sales_py_bytd_net_val / E.exchange_rate AS sales_py_bytd_net_val,
  R.return_py_bytd_net_val / E.exchange_rate AS return_py_bytd_net_val,
  R.turnover_py_bytd_net_val / E.exchange_rate AS turnover_py_bytd_net_val,
  R.perf_adj_turnover_py_bytd_net_val / E.exchange_rate AS perf_adj_turnover_py_bytd_net_val,
  R.sales_py_swday_net_val / E.exchange_rate AS sales_py_swday_net_val,
  R.return_py_swday_net_val / E.exchange_rate AS return_py_swday_net_val,
  R.turnover_py_swday_net_val / E.exchange_rate AS turnover_py_swday_net_val,
  R.perf_adj_turnover_py_swday_net_val / E.exchange_rate AS perf_adj_turnover_py_swday_net_val,
  R.sales_py_swday_bytd_net_val / E.exchange_rate AS sales_py_swday_bytd_net_val,
  R.return_py_swday_bytd_net_val / E.exchange_rate AS return_py_swday_bytd_net_val,
  R.turnover_py_swday_bytd_net_val / E.exchange_rate AS turnover_py_swday_bytd_net_val,
  R.perf_adj_turnover_py_swday_bytd_net_val / E.exchange_rate AS perf_adj_turnover_py_swday_bytd_net_val,
  R.perf_adj_turnover_ppy_net_val / E.exchange_rate AS perf_adj_turnover_ppy_net_val,
  R.perf_adj_turnover_ppy_bytd_net_val / E.exchange_rate AS perf_adj_turnover_ppy_bytd_net_val,
  R.perf_adj_turnover_ppy_swday_net_val / E.exchange_rate AS perf_adj_turnover_ppy_swday_net_val,
  R.perf_adj_turnover_ppy_swday_bytd_net_val / E.exchange_rate AS perf_adj_turnover_ppy_swday_bytd_net_val,
 R.sales_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_qty * 0.453592
  ELSE R.sales_qty
  END AS sales_qty,
 R.sales_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_bytd_qty * 0.453592
  ELSE R.sales_bytd_qty
  END AS sales_bytd_qty,
 R.sales_py_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_py_qty * 0.453592
  ELSE R.sales_py_qty
  END AS sales_py_qty,
 R.sales_py_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_py_bytd_qty * 0.453592
  ELSE R.sales_py_bytd_qty
  END AS sales_py_bytd_qty,
 R.sales_py_swday_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_py_swday_qty * 0.453592
  ELSE R.sales_py_swday_qty
  END AS sales_py_swday_qty,
 R.sales_py_swday_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.sales_py_swday_bytd_qty * 0.453592
  ELSE R.sales_py_swday_bytd_qty
  END AS sales_py_swday_bytd_qty,
 R.return_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_qty * 0.453592
  ELSE R.return_qty
  END AS return_qty,
 R.return_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_bytd_qty * 0.453592
  ELSE R.return_bytd_qty
  END AS return_bytd_qty,
 R.return_py_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_py_qty * 0.453592
  ELSE R.return_py_qty
  END AS return_py_qty,
 R.return_py_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_py_bytd_qty * 0.453592
  ELSE R.return_py_bytd_qty
  END AS return_py_bytd_qty,
 R.return_py_swday_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_py_swday_qty * 0.453592
  ELSE R.return_py_swday_qty
  END AS return_py_swday_qty,
 R.return_py_swday_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.return_py_swday_bytd_qty * 0.453592
  ELSE R.return_py_swday_bytd_qty
  END AS return_py_swday_bytd_qty,
 R.perf_adj_sales_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_qty * 0.453592
  ELSE R.perf_adj_sales_qty
  END AS perf_adj_sales_qty,
 R.perf_adj_sales_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_bytd_qty * 0.453592
  ELSE R.perf_adj_sales_bytd_qty
  END AS perf_adj_sales_bytd_qty,
 R.perf_adj_sales_py_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_py_qty * 0.453592
  ELSE R.perf_adj_sales_py_qty
  END AS perf_adj_sales_py_qty,
 R.perf_adj_sales_py_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_py_bytd_qty * 0.453592
  ELSE R.perf_adj_sales_py_bytd_qty
  END AS perf_adj_sales_py_bytd_qty,
 R.perf_adj_sales_py_swday_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_py_swday_qty * 0.453592
  ELSE R.perf_adj_sales_py_swday_qty
  END AS perf_adj_sales_py_swday_qty,
 R.perf_adj_sales_py_swday_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_sales_py_swday_bytd_qty * 0.453592
  ELSE R.perf_adj_sales_py_swday_bytd_qty
  END AS perf_adj_sales_py_swday_bytd_qty,
 R.perf_adj_return_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_qty * 0.453592
  ELSE R.perf_adj_return_qty
  END AS perf_adj_return_qty,
 R.perf_adj_return_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_bytd_qty * 0.453592
  ELSE R.perf_adj_return_bytd_qty
  END AS perf_adj_return_bytd_qty,
 R.perf_adj_return_py_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_py_qty * 0.453592
  ELSE R.perf_adj_return_py_qty
  END AS perf_adj_return_py_qty,
 R.perf_adj_return_py_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_py_bytd_qty * 0.453592
  ELSE R.perf_adj_return_py_bytd_qty
  END AS perf_adj_return_py_bytd_qty,
 R.perf_adj_return_py_swday_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_py_swday_qty * 0.453592
  ELSE R.perf_adj_return_py_swday_qty
  END AS perf_adj_return_py_swday_qty,
 R.perf_adj_return_py_swday_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_return_py_swday_bytd_qty * 0.453592
  ELSE R.perf_adj_return_py_swday_bytd_qty
  END AS perf_adj_return_py_swday_bytd_qty,
 R.perf_adj_total_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_qty * 0.453592
  ELSE R.perf_adj_total_qty
  END AS perf_adj_total_qty,
 R.perf_adj_total_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_bytd_qty * 0.453592
  ELSE R.perf_adj_total_bytd_qty
  END AS perf_adj_total_bytd_qty,
 R.perf_adj_total_py_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_py_qty * 0.453592
  ELSE R.perf_adj_total_py_qty
  END AS perf_adj_total_py_qty,
 R.perf_adj_total_py_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_py_bytd_qty * 0.453592
  ELSE R.perf_adj_total_py_bytd_qty
  END AS perf_adj_total_py_bytd_qty,
 R.perf_adj_total_py_swday_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_py_swday_qty * 0.453592
  ELSE R.perf_adj_total_py_swday_qty
  END AS perf_adj_total_py_swday_qty,
 R.perf_adj_total_py_swday_bytd_cnt,
  CASE
  WHEN R.country_org_cd = 'US'
  THEN R.perf_adj_total_py_swday_bytd_qty * 0.453592
  ELSE R.perf_adj_total_py_swday_bytd_qty
  END AS perf_adj_total_py_swday_bytd_qty,
 R.dwh_created_tmsp,
 R.dwh_updated_tmsp,
 R.dwh_load_id,
 R.dwh_node_cd
FROM ldl_data_core_dim.v_fact_retail_by_store_day_product AS R
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS E ON R.curr_cd = E.tgt_curr_cd
WHERE E.exchange_rate_type_cd = 'BEW_ISK'
 AND (E.src_curr_cd = 'EUR' OR E.src_curr_cd = E.tgt_curr_cd)
 AND E.active_fg;