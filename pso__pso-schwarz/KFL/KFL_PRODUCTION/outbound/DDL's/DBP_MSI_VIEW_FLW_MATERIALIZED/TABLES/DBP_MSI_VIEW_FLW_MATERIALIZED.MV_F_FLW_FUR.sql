CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_fur (
mandant_id INTEGER,
in_art_id INTEGER,
in_kunde_id INTEGER,
dat DATE,
einh_id STRING(3) COLLATE 'und:ci',
menge_sicherheit NUMERIC(29,3),
menge_plan NUMERIC(29,3),
dat_erstellung DATE
);