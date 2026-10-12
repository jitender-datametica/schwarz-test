CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_besch_best_1 (
mandant_id INTEGER,
best_beleg_id INTEGER,
gp_id INTEGER,
dat_best_beleg DATE,
bestellart_id STRING(4) COLLATE 'und:ci',
best_beleg_status_id STRING(1) COLLATE 'und:ci',
loesch_fg INTEGER,
nachbest_fg INTEGER,
einkaufsorganisation_id INTEGER,
dat_aenderung DATE,
kunde_id STRING(10) COLLATE 'und:ci',
wup_id INTEGER,
nb_id INTEGER,
system_id INTEGER,
kj INTEGER,
submi_id STRING(10) COLLATE 'und:ci',
ref_beleg_id_intern STRING(20) COLLATE 'und:ci'
);