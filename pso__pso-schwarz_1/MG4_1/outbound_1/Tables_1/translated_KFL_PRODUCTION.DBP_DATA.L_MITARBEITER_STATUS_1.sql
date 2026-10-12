CREATE OR REPLACE TABLE kfl_production_dbp_data.l_mitarbeiter_status_1 (
mandant_id INTEGER NOT NULL,
ma_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);