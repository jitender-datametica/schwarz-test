CREATE TABLE IF NOT EXISTS szd_etl_process.ts_rvm_deact_status_2 (
rvm_sid BIGNUMERIC(38,0),
inserted_tmsp DATETIME,
transaction_status STRING(16777216),
transaction_tmsp DATETIME,
dwh_created_tmsp DATETIME,
dwh_updated_tmsp DATETIME
);