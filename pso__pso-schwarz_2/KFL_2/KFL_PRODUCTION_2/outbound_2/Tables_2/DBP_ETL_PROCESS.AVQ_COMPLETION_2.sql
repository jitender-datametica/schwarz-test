CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.avq_completion_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjwo BIGNUMERIC(38,0) NOT NULL,
last_run DATETIME,
td_insert TIMESTAMP,
td_update TIMESTAMP
);