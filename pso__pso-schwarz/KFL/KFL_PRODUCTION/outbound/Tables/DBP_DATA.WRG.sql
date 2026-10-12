CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wrg (
wrg_id STRING(12) COLLATE 'und:ci' NOT NULL,
wrg_bez STRING(160) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP1_MIS - Waehrung');