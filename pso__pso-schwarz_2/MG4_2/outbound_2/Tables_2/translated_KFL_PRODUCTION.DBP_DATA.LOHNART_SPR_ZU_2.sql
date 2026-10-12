CREATE OR REPLACE TABLE kfl_production_dbp_data.lohnart_spr_zu_2 (
mandant_id INTEGER NOT NULL,
lohnart_id STRING(5) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
lohnart_bez STRING(25) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);