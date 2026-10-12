CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.kmo_kunde_2 (
mandant_sap_id BIGNUMERIC(38,0) NOT NULL,
kunde_id STRING(10) NOT NULL,
mandant_kbez STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);