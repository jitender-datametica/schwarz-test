CREATE OR REPLACE TABLE kfl_production_dbp_data.l_altersteilzeit_2 (
mandant_id INTEGER NOT NULL,
atz_phase_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);