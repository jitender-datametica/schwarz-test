CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_retail_by_store_day_product (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, which has generated the revenue.'),
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
sales_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales variant of a product.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization. This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is on the one hand related to the country organization which is responsible for the store which has sold the product, and on the other hand to the country organization which has defined the local properties of the product.'),
sales_cnt INTEGER
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'),
sales_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day.'),
return_cnt INTEGER
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'),
return_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day.'),
perf_adj_sales_cnt INTEGER
OPTIONS(description='The number of this sales variant which have been sold in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products. (This attribute is empty for weight-based products.)'),
perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been sold in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'),
perf_adj_return_cnt INTEGER
OPTIONS(description='The number of this sales variant which have been returned in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_return_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the sales variant which have been returned in the given store on the given day. Only variants of products with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered.'),
uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit of measure for weight based products. (kg, ...)'),
cash_register_sales_net_val NUMERIC(29,5)
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_sales_gross_val NUMERIC(29,5)
OPTIONS(description='The sales portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_gross_val NUMERIC(29,5)
OPTIONS(description='The return portion of the gross turnover which was generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cash register.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
perf_adj_sales_net_val NUMERIC(29,5)
OPTIONS(description='The sales portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated for this sales variant in the given store on the given day. Only product variants with an international item group or commission products with an absolute unit price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
PRIMARY KEY (bus_dt, store_sid, sales_variant_sid) NOT ENFORCED
);