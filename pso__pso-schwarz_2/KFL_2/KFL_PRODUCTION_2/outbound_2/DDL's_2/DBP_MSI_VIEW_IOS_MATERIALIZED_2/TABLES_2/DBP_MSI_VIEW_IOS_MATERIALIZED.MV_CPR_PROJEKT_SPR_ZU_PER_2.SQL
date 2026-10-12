CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_cpr_projekt_spr_zu_per_2 (
projekt_id STRING(32) COLLATE 'und:ci',
projekt_nr STRING(30) COLLATE 'und:ci',
spr_id INTEGER,
cpr_projekt_bez STRING(40) COLLATE 'und:ci',
cpr_projekt_langtext STRING(320) COLLATE 'und:ci',
projekt_kbez STRING(80),
mandant_id INTEGER,
dat_von DATE,
dat_bis DATE,
dat DATE
);