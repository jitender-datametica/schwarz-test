CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_ma_pers_teilbereich_zu_per_1 (
mandant_id INTEGER,
pers_bereich_id STRING(4) COLLATE 'und:ci',
pers_teilbereich_id STRING(4) COLLATE 'und:ci',
mitarbeiter_id STRING(20),
kjmo INTEGER,
buchungskreis_id INTEGER,
persteilbereich_bez STRING(20) COLLATE 'und:ci'
);