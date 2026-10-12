CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.marktbestand_wg_sum_st (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
dat_process DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);