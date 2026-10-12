CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_region (
land_id STRING(2) COLLATE 'und:ci',
region_id INTEGER,
mandant_id INTEGER,
sap_region_id STRING(3) COLLATE 'und:ci',
region_name STRING(50) COLLATE 'und:ci'
);