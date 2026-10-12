CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm_materialized.mv_aof_prognose_vs_bestellung_1 (
mandant_id INTEGER,
art_id INTEGER,
aof_dat DATE,
bestellart_id INTEGER,
menge_prognose NUMERIC(29,3),
wup_id INTEGER,
nb_id INTEGER,
zeitreihenart STRING(10),
dat_prognoselauf DATE,
menge_best_bme NUMERIC(29,3)
);