CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.marked_receipts_extract (
bon_id STRING(25),
bon_dat DATE,
wup_id INTEGER,
mandant_id INTEGER,
aad_request_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);