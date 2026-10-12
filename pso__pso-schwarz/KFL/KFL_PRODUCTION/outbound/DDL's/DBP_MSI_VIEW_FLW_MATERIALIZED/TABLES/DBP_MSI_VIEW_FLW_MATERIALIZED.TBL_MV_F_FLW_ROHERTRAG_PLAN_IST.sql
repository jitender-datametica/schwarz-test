CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_rohertrag_plan_ist (
mandant_id INTEGER,
in_art_id INTEGER,
gjmo INTEGER,
plan_fg INTEGER,
werk_id INTEGER,
rohertrag_betrag_org NUMERIC(29,4),
wrg_id_org STRING(3) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
max_dat DATE,
default_wrg STRING(12) COLLATE 'und:ci'
);