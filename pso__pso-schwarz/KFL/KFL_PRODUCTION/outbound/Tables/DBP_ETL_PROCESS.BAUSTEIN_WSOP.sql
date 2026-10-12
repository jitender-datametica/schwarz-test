CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.baustein_wsop (
mandant_id BIGNUMERIC(38,0),
baustein_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
dat_von DATE,
dat_bis DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);