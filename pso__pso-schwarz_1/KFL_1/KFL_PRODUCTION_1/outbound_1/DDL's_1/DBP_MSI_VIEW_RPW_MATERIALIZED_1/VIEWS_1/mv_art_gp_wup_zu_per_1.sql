CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_art_gp_wup_zu_per_1 (
mandant_id INTEGER,
art_id INTEGER,
gp_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
einkaufsorganisation_id INTEGER,
dat_von DATE,
dat_bis DATE,
bezugsweg_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
komponentenmenge NUMERIC(29,4),
system_id INTEGER
);