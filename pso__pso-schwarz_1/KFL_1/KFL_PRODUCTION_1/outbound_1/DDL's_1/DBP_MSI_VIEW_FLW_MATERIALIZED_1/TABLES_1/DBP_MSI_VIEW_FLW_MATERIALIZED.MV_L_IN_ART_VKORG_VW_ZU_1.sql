CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_art_vkorg_vw_zu_1 (
mandant_id INTEGER,
in_verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
in_art_id INTEGER,
in_vw_id INTEGER,
art_status_id STRING(2) COLLATE 'und:ci',
verk_menge_einh_id STRING(3) COLLATE 'und:ci',
werk_id INTEGER,
umrech_faktor_bme NUMERIC(29,5)
);