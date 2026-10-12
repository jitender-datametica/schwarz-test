CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_lagernummer_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
lager_bereich_kz STRING(3) COLLATE 'und:ci',
einlager_typ_kz STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL,
lager_einheiten_typ STRING(3) COLLATE 'und:ci',
kapazitaet_verbrauch NUMERIC(9,3) DEFAULT 0 NOT NULL,
anz_ladtraeger_max BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
stellplatz_faktor NUMERIC(9,2) DEFAULT 1 NOT NULL,
zlv_ladhilf_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);