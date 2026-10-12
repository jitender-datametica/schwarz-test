CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rfi_fehler_1 (
rfi_id BIGNUMERIC(38,0) NOT NULL,
rfi_fehlergrund STRING(2000) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);