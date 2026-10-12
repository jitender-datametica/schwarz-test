CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_matching_nielsen_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_matching_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
art_nielsen_id BIGNUMERIC(38,0) NOT NULL,
gtin_id INTEGER NOT NULL,
kl_art_kat_id BIGNUMERIC(38,0) NOT NULL,
kl_wg_id BIGNUMERIC(38,0) NOT NULL,
kl_owg_id BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
umrech_faktor FLOAT64,
status_2 STRING(4) COLLATE 'und:ci',
list_kz STRING(8) COLLATE 'und:ci',
komponente_fg BIGNUMERIC(38,0),
kjwo_update BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);