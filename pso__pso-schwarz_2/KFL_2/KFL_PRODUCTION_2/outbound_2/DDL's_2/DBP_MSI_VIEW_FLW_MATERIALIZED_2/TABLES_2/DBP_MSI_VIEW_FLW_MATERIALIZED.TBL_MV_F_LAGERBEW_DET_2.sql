DROP TABLE IF EXISTS kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_lagerbew_det_2;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_lagerbew_det_2 (
lagerbew_beleg_id INTEGER,
lagerbew_beleg_pos_id INTEGER,
mandant_id INTEGER,
kj INTEGER,
wup_id INTEGER,
nb_id INTEGER,
in_kunde_id INTEGER,
dat_buch DATE,
art_id INTEGER,
in_art_id INTEGER,
lager_bewart_id STRING(3) COLLATE 'und:ci',
menge_lagerbew_bme NUMERIC(29,3),
menge_lagerbew_kg NUMERIC(29,6),
wrg_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
betrag_vk_netto NUMERIC(29,2),
mwst NUMERIC(29,2)
) CLUSTER BY mandant_id;