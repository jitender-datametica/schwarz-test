CREATE OR REPLACE TABLE kfl_production_dbp_data.l_ma_tarifgebiet_2 (
mandant_id INTEGER NOT NULL,
tarifgebiet_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);