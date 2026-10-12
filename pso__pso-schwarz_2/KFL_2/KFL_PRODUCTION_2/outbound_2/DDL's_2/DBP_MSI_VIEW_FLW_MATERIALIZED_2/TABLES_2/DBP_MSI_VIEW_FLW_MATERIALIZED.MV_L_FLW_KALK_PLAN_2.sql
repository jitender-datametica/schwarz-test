CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_kalk_plan_2 (
mandant_id INTEGER,
plan_kalk_id INTEGER,
schnittliste_id INTEGER,
werk_id INTEGER,
dat_kalk_ab DATE,
dat_kalk_bis DATE,
fortgesch_kalk_fg INTEGER,
kalk_variante_id STRING(4) COLLATE 'und:ci'
);