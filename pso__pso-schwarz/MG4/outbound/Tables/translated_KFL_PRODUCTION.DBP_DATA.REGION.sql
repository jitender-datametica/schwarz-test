CREATE OR REPLACE TABLE kfl_production_dbp_data.region (
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
region_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
sap_region_id STRING(3) COLLATE 'und:ci' NOT NULL,
region_name STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);