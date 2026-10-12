CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_cbx_cnt_codelist_book_1 (
id STRING(32) NOT NULL,
revision INTEGER,
entity_version INTEGER,
domain_id STRING(400),
hub_domain_id STRING(400),
is_for_reference INTEGER,
version INTEGER,
status_1 STRING(400),
doc_status STRING(400),
editing_status STRING(400),
create_user STRING(100),
create_user_name STRING(100),
update_user STRING(100),
update_user_name STRING(100),
created_on DATETIME,
updated_on DATETIME,
integration_source STRING(400),
integration_status_1 STRING(400),
integration_note STRING(1000),
is_cpm_initialized INTEGER,
is_latest INTEGER,
name STRING(400),
type_id STRING(32),
effective_from DATETIME,
effective_to DATETIME,
description STRING(1000),
ref_no STRING(1000),
business_ref_no STRING(1000),
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