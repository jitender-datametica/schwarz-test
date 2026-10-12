CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.check_mlgt_1 (
bezugsdatum DATE NOT NULL,
table_name STRING(30) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
cycle_id BIGNUMERIC(38,0),
loop_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);