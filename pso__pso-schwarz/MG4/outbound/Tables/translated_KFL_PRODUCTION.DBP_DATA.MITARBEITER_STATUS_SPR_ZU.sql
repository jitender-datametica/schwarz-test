CREATE OR REPLACE TABLE kfl_production_dbp_data.mitarbeiter_status_spr_zu (
mandant_id INTEGER NOT NULL,
ma_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
ma_status_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);