DROP TABLE IF EXISTS dbp_msi_view_flw_materialized.tbl_mv_f_art_bewertung_2;
CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_art_bewertung_2 (
mandant_id INTEGER,
werk_id INTEGER,
werk_nr STRING(4) COLLATE 'und:ci',
werk_name STRING(30) COLLATE 'und:ci',
bewertungskreis_id STRING(4) COLLATE 'und:ci',
in_art_id INTEGER,
preis_steuer_kz STRING(1) COLLATE 'und:ci',
gld NUMERIC(29,6),
standard_preis NUMERIC(29,4),
preis_faktor INTEGER,
dat_von DATE,
dat_bis DATE,
umrech_faktor BIGNUMERIC(38,14),
dat DATE,
wrg_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
basismenge_einh_id STRING(3) COLLATE 'und:ci'
) CLUSTER BY mandant_id, werk_id;