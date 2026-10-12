CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_saphana_cv_mo_umsatz_kunde_2 (
extraction_ts DATETIME,
extraction_date DATE,
source_system STRING(50),
bic_zmlila STRING(5),
kyf_id STRING(1000),
kyf_type STRING(1000),
urgunit STRING(1000),
vlxmlcntr STRING(1000),
calyear STRING(1000),
calday STRING(1000),
vlxecukyl STRING(1000),
fiscyear STRING(1000),
vlxmvers STRING(1000),
kyf_all INTEGER,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);