CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verrechfall_status (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verrechfall_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);