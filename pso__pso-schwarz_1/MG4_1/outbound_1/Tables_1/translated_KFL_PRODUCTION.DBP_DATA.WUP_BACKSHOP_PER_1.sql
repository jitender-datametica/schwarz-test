CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_backshop_per_1 (
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
anz_ofen INTEGER NOT NULL,
gp_backen_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);