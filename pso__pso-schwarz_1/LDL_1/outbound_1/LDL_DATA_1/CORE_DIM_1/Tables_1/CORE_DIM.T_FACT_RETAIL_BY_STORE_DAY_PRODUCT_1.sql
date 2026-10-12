CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_retail_by_store_day_product_1 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, which has generated the revenue.'),
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
sales_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 variant of a product.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization. This is on the one hand related to the country_1 organization which is responsible for the store which has sold the product, and on the other hand to the country_1 organization which has defined the local properties of the product.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.) This is on the one hand related to the country_1 organization which is responsible for the store which has sold the product, and on the other hand to the country_1 organization which has defined the local properties of the product.'),
sales_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this sales_1 variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'),
sales_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day.'),
return_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this sales_1 variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'),
return_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day.'),
perf_adj_sales_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this sales_1 variant which have been sold in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products. (This attribute is empty for weight-based products.)'),
perf_adj_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales_1 variant which have been sold in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered.'),
perf_adj_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated for this sales_1 variant in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this sales_1 variant which have been returned in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_return_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales_1 variant which have been returned in the given store on the given day. Only variants of products with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered.'),
perf_adj_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the net turnover which was generated for this sales_1 variant in the given store on the given day. Only product variants with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit_1 of measure for weight based products. (kg, ...)'),
cash_register_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_1 portion of the gross turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the net turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the gross turnover which was generated for this sales_1 variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, store_sid, sales_variant_sid) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='An aggregate fact holding basic retail measures per day, product and store. This includes sales_1 and return volume and the gross and net turnover. (Turnover amounts are taken from the cash register.)');