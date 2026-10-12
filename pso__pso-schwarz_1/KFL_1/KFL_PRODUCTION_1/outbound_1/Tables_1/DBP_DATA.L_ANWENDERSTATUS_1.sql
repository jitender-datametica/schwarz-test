CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_anwenderstatus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anwenderstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);