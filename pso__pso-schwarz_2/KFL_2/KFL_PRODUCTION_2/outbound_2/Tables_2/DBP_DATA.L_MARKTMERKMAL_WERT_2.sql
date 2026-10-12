CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_marktmerkmal_wert_2 (
marktmerkmal_id STRING(4) COLLATE 'und:ci' NOT NULL,
marktmerkmal_wert STRING(10) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);