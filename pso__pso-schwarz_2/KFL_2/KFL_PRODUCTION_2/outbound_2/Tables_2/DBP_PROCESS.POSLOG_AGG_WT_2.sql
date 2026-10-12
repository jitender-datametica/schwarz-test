CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.poslog_agg_wt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_poslog DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);