CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_variant_sales_price (
prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales variant of a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sales_gross_price NUMERIC(29,5) NOT NULL
OPTIONS(description='The gross price for which this product variant is sold in the store.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
price_grp_sid INTEGER NOT NULL
OPTIONS(description='the unique identifier (surrogate key) for the price level of a product.'),
price_reason_cd STRING(20)
OPTIONS(description='the code identifying the reason why a price was defined for a product. e.g. permanent price change, promotional price, etc.'),
PRIMARY KEY (prod_variant_sid, price_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity tracks the sales price of a product, depending on the price level.');