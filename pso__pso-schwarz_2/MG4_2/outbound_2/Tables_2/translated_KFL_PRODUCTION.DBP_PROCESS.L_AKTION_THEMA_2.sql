CREATE OR REPLACE TABLE kfl_production_dbp_process.l_aktion_thema_2 (
aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
aktion_thema_gruppe_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);