CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_art_nielsen_matching_zu_kmo_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_matching_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
art_nielsen_id BIGNUMERIC(38,0) NOT NULL,
gtin_id INTEGER NOT NULL,
kl_art_kat_id BIGNUMERIC(38,0) NOT NULL,
kl_wg_id BIGNUMERIC(38,0) NOT NULL,
kl_owg_id BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
umrech_faktor BIGNUMERIC(38,5),
status_2 STRING(1),
list_kz STRING(2),
komponente_fg BIGNUMERIC(38,0),
kjwo_update BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);