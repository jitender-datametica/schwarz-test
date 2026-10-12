CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kasse_typ_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
kasse_nr BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
kasse_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);