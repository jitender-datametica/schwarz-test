CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_cbx_ldl_item_packing_method (
id STRING(32) NOT NULL,
revision NUMERIC(20,0),
entity_version NUMERIC(20,0),
domain_id STRING(400),
hub_domain_id STRING(400),
is_for_reference INTEGER,
internal_seq_no NUMERIC(20,0),
item_id STRING(32),
ldl_seq NUMERIC(20,0),
ldl_code STRING(400),
ldl_name STRING(400),
ldl_total_pack_ratio NUMERIC(20,0),
ldl_country_block_names STRING(1000),
ldl_country_names STRING(1000),
ldl_country_codes STRING(1000),
ldl_pack_notes_instruction STRING(1000),
ldl_assortment_size_quantities STRING(1000),
ldl_overwritten_units_per_c_0 NUMERIC(20,0),
duid STRING(100),
ldl_packing_method_unique_id STRING(400),
extraction_dt DATE,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);