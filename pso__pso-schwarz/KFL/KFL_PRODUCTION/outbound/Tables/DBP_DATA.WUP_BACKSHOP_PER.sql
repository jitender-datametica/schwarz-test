CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_backshop_per (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
anz_ofen BIGNUMERIC(38,0) NOT NULL,
gp_backen_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);