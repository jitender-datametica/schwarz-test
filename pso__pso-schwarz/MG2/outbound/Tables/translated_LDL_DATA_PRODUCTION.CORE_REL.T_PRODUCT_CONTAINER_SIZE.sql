CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_container_size (
prod_container_size_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the size class for module containers. (XS, small / medium / large)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_container_size_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the size class for module containers.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_container_size_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the size of surface containers. There are three size classes: XS, small, medium and large.');