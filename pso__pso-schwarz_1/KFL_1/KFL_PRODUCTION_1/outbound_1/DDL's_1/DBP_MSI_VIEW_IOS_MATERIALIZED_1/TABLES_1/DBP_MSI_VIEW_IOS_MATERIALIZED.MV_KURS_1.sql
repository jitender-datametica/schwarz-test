CREATE OR REPLACE TABLE dbp_msi_view_ios_materialized.mv_kurs_1 (
kurstyp_id INTEGER,
von_wrg_id STRING(12) COLLATE 'und:ci',
dat_von DATE,
dat_bis DATE,
umrechnungskurs NUMERIC(29,5),
nach_wrg_id STRING(12) COLLATE 'und:ci'
);