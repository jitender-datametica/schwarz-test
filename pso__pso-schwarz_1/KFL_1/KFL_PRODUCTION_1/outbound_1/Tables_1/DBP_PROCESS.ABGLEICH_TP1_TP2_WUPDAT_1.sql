CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.abgleich_tp1_tp2_wupdat_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dl_artbew_wg_sum BIGNUMERIC(38,0),
dl_artbew BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);