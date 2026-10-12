CREATE OR REPLACE TABLE kfl_production_dbp_data.in_werk_2 (
mandant_id INTEGER NOT NULL,
werk_id INTEGER NOT NULL,
werk_nr STRING(4) COLLATE 'und:ci' NOT NULL,
werk_name STRING(30) COLLATE 'und:ci' NOT NULL,
system_id INTEGER NOT NULL,
sako_fg INTEGER DEFAULT 0 NOT NULL,
buchungskreis_id INTEGER DEFAULT - 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);