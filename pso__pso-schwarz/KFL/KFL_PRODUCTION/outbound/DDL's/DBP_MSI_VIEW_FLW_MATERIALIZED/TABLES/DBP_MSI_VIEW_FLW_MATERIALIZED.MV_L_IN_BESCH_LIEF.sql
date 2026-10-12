CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_besch_lief (
lief_beleg_id INTEGER,
mandant_id INTEGER,
werk_id INTEGER,
in_kunde_id INTEGER,
kunde_nr STRING(15) COLLATE 'und:ci',
kunde_name STRING(40) COLLATE 'und:ci',
lief_typ_id STRING(4) COLLATE 'und:ci',
dat_beleg DATE,
dat_erfasst DATE,
dat_lief_soll DATE,
in_verkaufsorganisation_id STRING(4) COLLATE 'und:ci'
);