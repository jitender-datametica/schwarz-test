CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_schnitt_output_det (
mandant_id INTEGER,
in_art_id INTEGER,
schnitt_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
schnitt_pos_id INTEGER,
menge_schnitt NUMERIC(29,3),
wrg_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
betrag_schnitt_output NUMERIC(29,4),
dat_kalk_ab_v02 DATE,
dat_kalk_ab_v03 DATE
);