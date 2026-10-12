CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_schnittlist_mat_kost_1 (
mandant_id INTEGER,
schnittliste_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
in_art_id INTEGER,
input_material_typ_id STRING(1) COLLATE 'und:ci',
kosten_block_id STRING(3) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
intern_var_kosten NUMERIC(29,6),
dat_kalk_ab_v02 DATE,
dat_kalk_ab_v03 DATE
);