CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_cbx_cnt_codelist (
id STRING(32) NOT NULL,
revision NUMERIC(20,0),
entity_version NUMERIC(20,0),
domain_id STRING(400),
hub_domain_id STRING(400),
is_for_reference INTEGER,
internal_seq_no NUMERIC(20,0),
parent_id STRING(32),
seq_no NUMERIC(20,0),
code STRING(400),
name STRING(400),
disabled INTEGER,
ref_no STRING(1000),
business_ref_no STRING(1000),
duid STRING(100),
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