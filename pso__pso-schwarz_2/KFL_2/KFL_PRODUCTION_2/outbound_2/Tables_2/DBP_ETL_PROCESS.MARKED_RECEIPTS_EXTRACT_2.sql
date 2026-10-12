CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.marked_receipts_extract_2 (
bon_id STRING(25),
bon_dat DATE,
wup_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
aad_request_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);