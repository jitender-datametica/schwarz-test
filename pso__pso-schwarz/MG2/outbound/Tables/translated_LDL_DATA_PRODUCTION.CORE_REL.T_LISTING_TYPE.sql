CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_listing_type (
list_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
list_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (list_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='The listing types distinguishes the regular assortment from seasonal products, promotional items, etc.');