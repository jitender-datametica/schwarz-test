CREATE OR REPLACE TABLE kfl_production_dbp_etl.baustein_region_zu (
mandant_id INTEGER NOT NULL,
baustein_id INTEGER NOT NULL,
region STRING(2) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);