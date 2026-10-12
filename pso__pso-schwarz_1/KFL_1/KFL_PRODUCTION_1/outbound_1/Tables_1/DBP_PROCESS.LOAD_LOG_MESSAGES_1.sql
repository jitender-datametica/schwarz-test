CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_log_messages_1 (
cycle_id BIGNUMERIC(38,0) NOT NULL,
loop_id BIGNUMERIC(38,0),
job_name STRING(150) COLLATE 'und:ci',
proc_name STRING(150) COLLATE 'und:ci',
proc_type STRING(5) COLLATE 'und:ci',
message STRING(3200) COLLATE 'und:ci',
recipient_grp_id BIGNUMERIC(38,0),
anzahl BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);