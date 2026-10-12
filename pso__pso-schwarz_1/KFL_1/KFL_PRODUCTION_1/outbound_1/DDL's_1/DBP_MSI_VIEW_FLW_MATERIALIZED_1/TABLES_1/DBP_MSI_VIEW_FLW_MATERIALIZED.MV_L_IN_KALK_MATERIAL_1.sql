CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_kalk_material_1 (
mandant_id INTEGER,
kalk_id INTEGER,
kalkulationsart_id STRING(2) COLLATE 'und:ci',
dat_kalk DATE,
kalk_version_id INTEGER,
bewertung_variante_id STRING(3) COLLATE 'und:ci',
in_art_id INTEGER,
werk_id INTEGER,
dat_kalk_ab DATE,
dat_kalk_bis DATE
);