CREATE OR REPLACE TABLE kfl_production_dbp_data.spr (
spr_id INTEGER NOT NULL,
spr_name STRING(40) COLLATE 'und:ci',
spr_iso STRING(2) COLLATE 'und:ci',
dwh_spr INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);