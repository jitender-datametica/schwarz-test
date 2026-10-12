CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.aof_prognose_backup_210806 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
zeitreihenart STRING(10) COLLATE 'und:ci' NOT NULL,
dat_prognoselauf DATE NOT NULL,
dat DATE NOT NULL,
menge NUMERIC(13,3) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);