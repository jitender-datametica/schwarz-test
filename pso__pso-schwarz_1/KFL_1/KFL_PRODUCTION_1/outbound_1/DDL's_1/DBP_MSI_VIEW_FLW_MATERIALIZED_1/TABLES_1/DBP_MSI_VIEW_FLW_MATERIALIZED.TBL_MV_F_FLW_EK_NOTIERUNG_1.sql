CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_ek_notierung_1 (
mandant_id INTEGER,
ek_notierung_id STRING(10),
dat DATE,
plan_fg INTEGER,
pjwo INTEGER,
default_wrg STRING(12) COLLATE 'und:ci',
wrg_id STRING(3),
betrag NUMERIC(29,2)
);