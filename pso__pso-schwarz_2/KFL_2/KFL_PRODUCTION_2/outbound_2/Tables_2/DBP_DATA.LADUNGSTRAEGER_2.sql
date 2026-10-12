CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ladungstraeger_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER DEFAULT - 1 NOT NULL,
lief_beleg_id INTEGER NOT NULL,
handling_unit_id_ext STRING(20) COLLATE 'und:ci' NOT NULL,
kj_lief_beleg BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
anz_ladtraeger BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
status_ladtraeger STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
dat_erstellung DATE NOT NULL,
anz_ladtraeger_orig BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
anz_ladtraeger_defekt BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);