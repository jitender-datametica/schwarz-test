CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.backshop_prognose (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
menge_prognose NUMERIC(9,3) DEFAULT 0 NOT NULL,
min_sicherh_bestand NUMERIC(18,3) NOT NULL,
listung_id BIGNUMERIC(38,0) NOT NULL,
aktion_fg BIGNUMERIC(38,0) NOT NULL,
menge_check NUMERIC(9,3) NOT NULL,
anteil_01 NUMERIC(9,2) NOT NULL,
anteil_02 NUMERIC(9,2) NOT NULL,
anteil_03 NUMERIC(9,2) NOT NULL,
anteil_04 NUMERIC(9,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);