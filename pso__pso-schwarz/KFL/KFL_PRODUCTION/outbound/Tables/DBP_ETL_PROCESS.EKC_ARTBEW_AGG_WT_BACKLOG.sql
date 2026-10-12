CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_artbew_agg_wt_backlog (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);