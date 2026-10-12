CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.bda_bon_fehlend (
dat_bon DATE NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_nr BIGNUMERIC(38,0) NOT NULL,
kasse_nr BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);