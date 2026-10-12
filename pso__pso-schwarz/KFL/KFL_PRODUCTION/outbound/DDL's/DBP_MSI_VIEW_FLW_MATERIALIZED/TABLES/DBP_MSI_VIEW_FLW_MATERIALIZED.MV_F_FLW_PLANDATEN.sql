CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_plandaten (
gjmo INTEGER,
kjmo INTEGER,
wup_id INTEGER,
nb_id INTEGER,
mandant_id INTEGER,
umsatz_anlieferung_plan NUMERIC(29,4),
rohertrag_anlieferung_plan NUMERIC(29,4),
abschrift_inventur_plan NUMERIC(29,4),
wrg_id STRING(3) COLLATE 'und:ci'
);