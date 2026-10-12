CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.land_mandant_zu (
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);