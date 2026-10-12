CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.hive_art_umbewertung_2 (
mandant_id BIGNUMERIC(38,0),
dat_umbew DATE,
load_process STRING(6) COLLATE 'und:ci',
load_date DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);