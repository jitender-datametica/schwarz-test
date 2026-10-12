CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_l_kalk_1 (
mandant_id INTEGER,
schnittliste_id INTEGER,
werk_id INTEGER,
dat_kalk_ab DATE,
dat_kalk_bis DATE,
fortgesch_kalk_fg INTEGER,
kalk_nr INTEGER,
kalk_bez STRING(40) COLLATE 'und:ci',
kalk_kennz STRING(3),
kalk_variante_id STRING(4) COLLATE 'und:ci',
plan_soll_kz STRING(1) COLLATE 'und:ci',
spr_id INTEGER
);