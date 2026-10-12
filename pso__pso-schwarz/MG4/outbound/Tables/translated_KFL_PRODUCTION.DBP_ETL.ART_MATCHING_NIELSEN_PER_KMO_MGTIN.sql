CREATE OR REPLACE TABLE kfl_production_dbp_etl.art_matching_nielsen_per_kmo_mgtin (
mandant_id INTEGER NOT NULL,
art_matching_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
art_nielsen_id INTEGER NOT NULL,
gtin_id INTEGER NOT NULL,
kl_art_kat_id INTEGER NOT NULL,
kl_wg_id INTEGER NOT NULL,
kl_owg_id INTEGER NOT NULL,
kl_uwg_id INTEGER NOT NULL,
umrech_faktor NUMERIC(29,5),
status STRING(1),
list_kz STRING(2),
komponente_fg INTEGER,
kjwo_update INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);