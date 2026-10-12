CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_art_nielsen_groups_2 (
mandant_id INTEGER,
art_matching_id INTEGER,
art_id INTEGER,
art_nielsen_id INTEGER,
gtin_id INTEGER,
kl_art_kat_id INTEGER,
kl_wg_id INTEGER,
kl_owg_id INTEGER,
kl_uwg_id INTEGER,
umrech_faktor NUMERIC(29,5),
status_2 STRING(1),
list_kz STRING(8) COLLATE 'und:ci',
komponente_fg INTEGER,
kjwo_update INTEGER,
art_gruppe_id INTEGER
);