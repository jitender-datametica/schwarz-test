CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_brand_1 (
brand_name STRING(100) NOT NULL OPTIONS(description='The name of the brand.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (brand_name) NOT ENFORCED
) OPTIONS(description='The brand_1 dimension lists the names under which products are marketed. (E.g. Milka, Lego, ...)');