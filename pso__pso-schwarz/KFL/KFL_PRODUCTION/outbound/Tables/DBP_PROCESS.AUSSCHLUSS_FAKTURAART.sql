CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ausschluss_fakturaart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);