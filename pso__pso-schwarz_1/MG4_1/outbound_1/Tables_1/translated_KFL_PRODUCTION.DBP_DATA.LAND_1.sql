CREATE OR REPLACE TABLE kfl_production_dbp_data.land_1 (
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
land_bez STRING(20) COLLATE 'und:ci' NOT NULL,
land_iso STRING(2) COLLATE 'und:ci' NOT NULL,
eu_land_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);