CREATE OR REPLACE TABLE kfl_production_dbp_data.profit_center_2 (
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id INTEGER NOT NULL,
wup_id INTEGER,
nb_id INTEGER,
werk_id INTEGER DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);