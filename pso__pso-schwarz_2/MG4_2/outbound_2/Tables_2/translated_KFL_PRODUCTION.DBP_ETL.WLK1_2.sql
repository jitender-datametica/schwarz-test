CREATE OR REPLACE TABLE kfl_production_dbp_etl.wlk1_2 (
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat_bis DATE NOT NULL,
mandant_id INTEGER NOT NULL,
list_quelle_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
struktur_art_id INTEGER NOT NULL,
baustein_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_aend DATE NOT NULL,
list_sap_id INTEGER NOT NULL,
loesch_fg INTEGER NOT NULL,
komponente_fg INTEGER NOT NULL,
td_insert TIMESTAMP
);