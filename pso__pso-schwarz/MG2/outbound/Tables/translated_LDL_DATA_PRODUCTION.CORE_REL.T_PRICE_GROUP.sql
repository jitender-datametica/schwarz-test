CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_price_group (
price_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the price level of a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
price_grp_nr INTEGER NOT NULL
OPTIONS(description='The number which identifies the price level within its country organization.'),
price_grp_name STRING(100) NOT NULL
OPTIONS(description='The name by which the price level is known in the country organization.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization which has defined the price level.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (price_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The sales price of a product varies depending on a number of factors, such as the location and the competitive situation of the store. During promotional periods prices for certain products are typically lower. The price group defines the price level. A product has a different sales price, depending on its price level.');