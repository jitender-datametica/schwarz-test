CREATE TABLE IF NOT EXISTS ldl_data_etl.t_kpges_ref_indicator_2_tcache_kpges_ref_indicator (
indicator_id BIGNUMERIC(38,0) NOT NULL,
indicator_desc STRING(200) COLLATE 'und:ci' NOT NULL,
indicator_valuetype STRING(15) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
extraction_date DATE,
src_record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci',
timestamp_fn DATETIME NOT NULL,
dc_server_id BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);