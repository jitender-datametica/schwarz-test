CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_art_gp_zu_per_2 (
art_id INTEGER,
mandant_id INTEGER,
gp_id INTEGER,
dat_von DATE,
herst_id INTEGER,
einkaufsorganisation_id INTEGER,
gp_art_id STRING(40) COLLATE 'und:ci',
dat_bis DATE,
mhd_zeitraum_dz INTEGER,
system_id INTEGER
);