CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.bda_kasse_bon_nr_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
kasse_nr BIGNUMERIC(38,0) NOT NULL,
kassierer_nr BIGNUMERIC(38,0) NOT NULL,
bon_nr BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
islogoff BIGNUMERIC(38,0) NOT NULL,
dat_bon_start DATE NOT NULL,
zeit_bon_start BIGNUMERIC(38,0) NOT NULL,
dat_bon_ende DATE NOT NULL,
zeit_bon_ende BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);