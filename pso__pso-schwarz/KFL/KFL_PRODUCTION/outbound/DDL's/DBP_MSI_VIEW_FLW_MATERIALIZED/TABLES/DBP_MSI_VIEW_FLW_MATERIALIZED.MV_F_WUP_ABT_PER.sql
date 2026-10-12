CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_wup_abt_per (
gjmo INTEGER,
wup_id INTEGER,
mandant_id INTEGER,
nb_id INTEGER,
abt_id INTEGER,
umsatz_netto_plan NUMERIC(29,2),
umsatz_netto_plan_wrg STRING(3) COLLATE 'und:ci',
umsatz_netto_plan_konz NUMERIC(29,2)
);