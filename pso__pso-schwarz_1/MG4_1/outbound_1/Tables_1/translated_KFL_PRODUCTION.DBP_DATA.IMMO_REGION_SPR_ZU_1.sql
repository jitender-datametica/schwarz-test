CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_region_spr_zu_1 (
mandant_id INTEGER NOT NULL,
region_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
region_bez STRING(20) COLLATE 'und:ci' DEFAULT '                    ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);