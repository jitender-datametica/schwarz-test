CREATE OR REPLACE TABLE kfl_production_dbp_etl.kmo_mseg_art_gp_wup_zu_2 (
mandant_id INTEGER NOT NULL,
lagerbew_beleg_id INTEGER NOT NULL,
lagerbew_beleg_pos_id INTEGER NOT NULL,
kj INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat_buch DATE NOT NULL,
anz_ek_infosatz INTEGER,
anz_ek_orderbuch INTEGER,
bq_gp_id INTEGER,
bq_ekorg INTEGER,
bq_findung_id INTEGER,
regel_gp_id INTEGER,
regel_ekorg INTEGER
);