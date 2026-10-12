CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_art_nielsen_groups (
mandant_id BIGNUMERIC(38,0),
art_matching_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
art_nielsen_id BIGNUMERIC(38,0),
gtin_id INTEGER,
kl_art_kat_id BIGNUMERIC(38,0),
kl_wg_id BIGNUMERIC(38,0),
kl_owg_id BIGNUMERIC(38,0),
kl_uwg_id BIGNUMERIC(38,0),
umrech_faktor BIGNUMERIC(38,5),
status STRING(1),
list_kz STRING(8) COLLATE 'und:ci',
komponente_fg BIGNUMERIC(38,0),
kjwo_update BIGNUMERIC(38,0),
art_gruppe_id BIGNUMERIC(38,0)
);