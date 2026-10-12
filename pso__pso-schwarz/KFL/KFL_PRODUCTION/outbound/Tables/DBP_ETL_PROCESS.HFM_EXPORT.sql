CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.hfm_export (
kjmo BIGNUMERIC(38,0) NOT NULL,
dat_export DATE NOT NULL,
request_repeat BIGNUMERIC(38,0) NOT NULL,
scenario STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);