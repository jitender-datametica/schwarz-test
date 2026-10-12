CREATE OR REPLACE TABLE kfl_production_dbp_etl.art_matching_nielsen_per_kmo_olds_1 (
mandant_id INTEGER,
art_matching_id INTEGER,
art_id INTEGER,
art_nielsen_id INTEGER,
gtin_id INTEGER,
kl_art_kat_id INTEGER,
kl_wg_id INTEGER,
kl_owg_id INTEGER,
kl_uwg_id INTEGER,
umrech_faktor FLOAT64,
status_1 STRING(4) COLLATE 'und:ci',
list_kz STRING(8) COLLATE 'und:ci',
komponente_fg INTEGER,
kjwo_update INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);