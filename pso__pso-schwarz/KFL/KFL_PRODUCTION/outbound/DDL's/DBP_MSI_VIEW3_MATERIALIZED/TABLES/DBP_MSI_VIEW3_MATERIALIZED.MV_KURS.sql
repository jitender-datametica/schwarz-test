CREATE OR REPLACE TABLE kfl_production_dbp_msi_view3_materialized.mv_kurs (
dat_bis DATE,
dat_von DATE,
kurstyp_id INTEGER,
nach_wrg_id STRING(12) COLLATE 'und:ci',
umrechnungskurs NUMERIC(29,5),
von_wrg_id STRING(12) COLLATE 'und:ci'
);