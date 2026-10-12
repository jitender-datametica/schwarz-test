CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.kundenanz_agg_wt (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0),
dat DATE,
calc_fg BIGNUMERIC(38,0),
dat_lief DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);