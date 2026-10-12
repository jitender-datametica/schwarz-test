CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ladungstraeger_resb_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
reservierung_id INTEGER NOT NULL,
reservierung_pos_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
erledigt_fg BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_ausstellung DATE NOT NULL,
anz_ladungstraeger NUMERIC(18,3) DEFAULT 0 NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
dat_aenderung DATE,
dat_bis DATE NOT NULL,
bewegung_erlaubt_fg BIGNUMERIC(38,0) NOT NULL,
spediteur_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);