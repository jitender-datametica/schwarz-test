CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_schnitt_input (
mandant_id INTEGER,
schnitt_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
dat_von DATE,
dat_bis DATE,
default_wrg STRING(12) COLLATE 'und:ci',
wrg_id_v01 STRING(3) COLLATE 'und:ci',
material_einzel_kosten NUMERIC(29,4)
);