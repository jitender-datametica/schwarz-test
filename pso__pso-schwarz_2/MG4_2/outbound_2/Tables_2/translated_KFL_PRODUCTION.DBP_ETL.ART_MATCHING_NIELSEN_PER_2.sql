CREATE OR REPLACE TABLE kfl_production_dbp_etl.art_matching_nielsen_per_2 (
mandant_id INTEGER NOT NULL,
art_matching_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
art_nielsen_id INTEGER NOT NULL,
gtin_id INTEGER NOT NULL,
kl_art_kat_id INTEGER NOT NULL,
kl_wg_id INTEGER NOT NULL,
kl_owg_id INTEGER NOT NULL,
kl_uwg_id INTEGER NOT NULL,
umrech_faktor FLOAT64,
status_2 STRING(4) COLLATE 'und:ci',
list_kz STRING(8) COLLATE 'und:ci',
komponente_fg INTEGER,
kjwo_update INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);