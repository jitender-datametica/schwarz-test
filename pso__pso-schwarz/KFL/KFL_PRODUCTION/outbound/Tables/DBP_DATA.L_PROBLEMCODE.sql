CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_problemcode (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemcode_id STRING(7) NOT NULL,
problemklasse_id STRING(10),
td_update TIMESTAMP,
td_insert TIMESTAMP
);