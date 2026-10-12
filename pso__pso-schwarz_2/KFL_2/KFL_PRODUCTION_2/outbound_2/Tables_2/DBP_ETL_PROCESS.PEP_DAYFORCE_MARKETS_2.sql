CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.pep_dayforce_markets_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat_import DATE NOT NULL,
delta_fg_day BIGNUMERIC(38,0) NOT NULL,
delta_fg_min BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);