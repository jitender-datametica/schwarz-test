CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.zact1_1 (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
aktion_thema_id STRING(8) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);