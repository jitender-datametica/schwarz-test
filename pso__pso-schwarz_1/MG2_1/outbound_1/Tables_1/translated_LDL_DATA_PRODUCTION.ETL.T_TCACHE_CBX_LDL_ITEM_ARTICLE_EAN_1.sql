CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_cbx_ldl_item_article_ean_1 (
id STRING(32) NOT NULL,
revision INTEGER,
entity_version INTEGER,
domain_id STRING(400),
hub_domain_id STRING(400),
is_for_reference INTEGER,
internal_seq_no INTEGER,
item_id STRING(32),
ldl_item_size_id STRING(32),
ldl_item_unique_style_id STRING(32),
ldl_ean STRING(400),
ldl_is_exist_quantity INTEGER,
ldl_item_size_ref STRING(1000),
ldl_item_unique_style_ref STRING(1000),
duid STRING(100),
ldl_unit_wt NUMERIC(25,5),
ldl_ean_kl STRING(400),
kl_is_exist_quantity INTEGER,
extraction_dt DATE,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);