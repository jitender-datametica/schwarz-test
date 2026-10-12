CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_best_beleg_status_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);