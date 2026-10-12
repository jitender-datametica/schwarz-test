CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_qual_meldung_1 (
mandant_id INTEGER,
qual_meldung_id INTEGER,
meldungsart_id STRING(2) COLLATE 'und:ci',
in_lief_id INTEGER,
best_beleg_id INTEGER,
zeit_pforte TIME,
dat_erfasst DATE,
min_dat_pruef_von DATE
);