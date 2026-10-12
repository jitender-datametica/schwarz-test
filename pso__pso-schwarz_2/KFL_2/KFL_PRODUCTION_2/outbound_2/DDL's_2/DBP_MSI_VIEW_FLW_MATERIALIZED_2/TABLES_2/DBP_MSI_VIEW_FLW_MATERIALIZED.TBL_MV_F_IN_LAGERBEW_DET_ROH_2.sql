CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_in_lagerbew_det_roh_2 (
mandant_id INTEGER,
werk_id INTEGER,
dat_buch DATE,
wrg_id_org STRING(3) COLLATE 'und:ci',
best_beleg_id INTEGER,
in_art_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
preis_steuer_kz STRING(1) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
betrag_lagerbew NUMERIC(29,4),
betrag_lagerbew_altnv NUMERIC(29,4)
);