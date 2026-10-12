CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_storno_nachkauf_2 (
mandant_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
dat DATE,
storno_fg INTEGER,
menge_kg_wunsch NUMERIC(29,3),
menge_kg_ist NUMERIC(29,3),
menge_bstmg_wunsch NUMERIC(29,3),
menge_bstmg_ist NUMERIC(29,3)
);