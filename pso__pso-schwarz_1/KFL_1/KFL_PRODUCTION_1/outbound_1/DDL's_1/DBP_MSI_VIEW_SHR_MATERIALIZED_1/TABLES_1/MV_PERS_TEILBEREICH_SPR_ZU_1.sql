CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_pers_teilbereich_spr_zu_1 (
mandant_id INTEGER,
pers_bereich_id STRING(4) COLLATE 'und:ci',
pers_teilbereich_id STRING(4) COLLATE 'und:ci',
buchungskreis_id INTEGER,
persteilbereich_bez STRING(20) COLLATE 'und:ci'
);