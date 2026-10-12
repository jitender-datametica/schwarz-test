CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_region (
region_id INTEGER,
sap_region_id STRING(3) COLLATE 'und:ci',
land_id STRING(2) COLLATE 'und:ci',
region_name STRING(50) COLLATE 'und:ci',
mandant_id INTEGER,
system_id INTEGER
);