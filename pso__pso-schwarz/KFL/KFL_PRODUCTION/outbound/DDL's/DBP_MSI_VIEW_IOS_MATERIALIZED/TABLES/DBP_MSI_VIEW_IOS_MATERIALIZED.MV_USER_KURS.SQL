CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_user_kurs (
mandant_id INTEGER,
wrg_typ_id INTEGER,
von_wrg_id STRING(12) COLLATE 'und:ci',
nach_wrg_id STRING(12) COLLATE 'und:ci',
umrechnungskurs NUMERIC(29,5),
kurs NUMERIC(29,5),
wrg_id STRING(12) COLLATE 'und:ci',
faktor NUMERIC(29,5)
);