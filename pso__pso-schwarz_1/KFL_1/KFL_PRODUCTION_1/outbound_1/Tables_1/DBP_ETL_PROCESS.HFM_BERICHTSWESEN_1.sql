CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.hfm_berichtswesen_1 (
gjmo BIGNUMERIC(38,0) NOT NULL,
min_mo_gj BIGNUMERIC(38,0) NOT NULL,
max_mo_gj BIGNUMERIC(38,0) NOT NULL,
wup_id STRING(7) COLLATE 'und:ci' NOT NULL,
konto_1 STRING(14) COLLATE 'und:ci' NOT NULL,
owg_id STRING(12) COLLATE 'und:ci' NOT NULL,
data STRING(255) COLLATE 'und:ci'
);