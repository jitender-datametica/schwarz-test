CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_bew_qual_1 (
mandant_id INTEGER,
best_beleg_id INTEGER,
werk_id INTEGER,
in_lief_id INTEGER,
dat_lief_wunsch DATE,
flw_beleg_typ_id STRING(2) COLLATE 'und:ci',
beleg_gruppe_id STRING(1) COLLATE 'und:ci',
zeit_differenz STRING(16777216),
ds_verspaetung STRING(16777216),
anz_best_beleg_ok INTEGER
);