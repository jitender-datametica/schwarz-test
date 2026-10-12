CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ausschluss_fakturaart (
mandant_id BIGNUMERIC(38,0),
fakturaart_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);