CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_art_umrechnung_faktor_per_1 (
mandant_id INTEGER,
art_id INTEGER,
altnv_menge_einh_id STRING(3),
bruttogew NUMERIC(29,3),
umrech_faktor BIGNUMERIC(38,22),
gew_einh_id STRING(3),
dat_von DATE,
dat_bis DATE,
system_id INTEGER
);