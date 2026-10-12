CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_l_buchungskreis (
mandant_id INTEGER,
buchungskreis_id INTEGER,
gj_variante_id STRING(2) COLLATE 'und:ci',
land_id STRING(2) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
system_id INTEGER,
kontenplan_id STRING(4) COLLATE 'und:ci',
buchungskreis_glob_id STRING(4) COLLATE 'und:ci'
);