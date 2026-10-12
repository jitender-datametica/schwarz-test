CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_teilprojekt_2 (
teilprojekt_id BIGNUMERIC(38,0) NOT NULL,
teilprojekt_name STRING(50) COLLATE 'und:ci' NOT NULL,
dat_beginn DATE,
dat_ende DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);