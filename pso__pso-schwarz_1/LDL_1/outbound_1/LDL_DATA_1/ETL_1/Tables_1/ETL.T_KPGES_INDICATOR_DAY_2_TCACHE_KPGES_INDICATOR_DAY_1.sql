CREATE TABLE IF NOT EXISTS ldl_data_etl.t_kpges_indicator_day_2_tcache_kpges_indicator_day_1 (
indicator_id BIGNUMERIC(38,0) NOT NULL,
indicator_type_id BIGNUMERIC(38,0) NOT NULL,
org_type_id BIGNUMERIC(38,0) NOT NULL,
country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
derived_country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
org_unit_nr BIGNUMERIC(38,0),
cy BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci',
val_indicator NUMERIC(18,4),
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
src_record_id INTEGER,
extraction_ts DATETIME,
extraction_date DATE,
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