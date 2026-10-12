CREATE OR REPLACE TABLE kfl_production_dbp_data.l_ausgeber_1 (
mandant_id INTEGER NOT NULL,
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL,
ausgeber_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);