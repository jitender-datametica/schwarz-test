CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_log_master_1 (
cycle_id BIGNUMERIC(38,0) NOT NULL,
date_start DATE NOT NULL,
date_end DATE,
time_start TIME,
time_end TIME,
status_1 BIGNUMERIC(38,0),
user_id BIGNUMERIC(38,0),
process_id BIGNUMERIC(38,0),
cfg_file_name STRING(150) COLLATE 'und:ci',
env_file_name STRING(150) COLLATE 'und:ci',
job_name STRING(150) COLLATE 'und:ci',
comment_text STRING(254) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);