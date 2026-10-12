DROP TABLE IF EXISTS ldl_data_production_core_rel.t_stock_1;
CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_stock_1 (
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country.)'),
bus_dt DATE NOT NULL OPTIONS(description='The date for which the stock quanity is calculated.'),
stock_sales_unit_cnt INTEGER
OPTIONS(description='The number of sales_1 variants (that belong to the given product) which are on stock. E.g. if there are two boxes with 20 sales_1 variants each, the stock count is 40. For weight-based products this attribute is empty.'),
stock_qty NUMERIC(29,5)
OPTIONS(description='The weight of the product which is on stock in the given store or warehouse, expressed in the indicated unit_1 of measure. (This attribute is only filled for weight-based products.)'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure for the stock quantity.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
PRIMARY KEY (prod_sid, int_org_sid, bus_dt) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='The stock entity describes, how many units of a certain product exist in a store or in a warehouse (i.e. a delivery company). Stock is shown either in kilograms (or any other unit_1 of measure describing its weight) or as the number of sales_1 variants of the respective product. So if there are two boxes with 20 sales_1 item_1 each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that should exist at the end of the business day. An inventory may correct the stock.');