CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_prozessbereich_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
prozessbereich_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);