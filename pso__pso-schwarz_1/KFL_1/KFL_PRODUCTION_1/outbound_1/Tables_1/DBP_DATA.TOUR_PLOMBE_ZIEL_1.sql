CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tour_plombe_ziel_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER NOT NULL,
plombe_id BIGNUMERIC(38,0) NOT NULL,
plombe_prozess_id BIGNUMERIC(38,0) NOT NULL,
plombe_aktivitaet BIGNUMERIC(38,0) NOT NULL,
dat_scan DATE,
zeit_scan BIGNUMERIC(38,0) NOT NULL,
info_code BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);