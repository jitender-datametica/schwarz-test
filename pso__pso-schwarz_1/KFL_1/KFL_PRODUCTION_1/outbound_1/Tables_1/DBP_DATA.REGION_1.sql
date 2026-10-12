CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.region_1 (
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
region_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sap_region_id STRING(3) COLLATE 'und:ci' NOT NULL,
region_name STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);