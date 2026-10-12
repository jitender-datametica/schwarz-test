CREATE OR REPLACE TABLE kfl_production_dbp_data.l_aktionsart (
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);