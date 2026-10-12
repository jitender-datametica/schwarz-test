CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.hive_art_umbewertung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_umbew DATE NOT NULL,
load_process STRING(6) COLLATE 'und:ci',
load_date DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);