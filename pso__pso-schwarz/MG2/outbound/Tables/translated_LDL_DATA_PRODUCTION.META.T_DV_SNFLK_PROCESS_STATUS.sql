CREATE OR REPLACE TABLE ldl_data_production_meta.t_dv_snflk_process_status (
techsystem STRING(250) NOT NULL,
techgroup STRING(250) NOT NULL,
dataset STRING(250) NOT NULL,
last_change_commit_time INTEGER,
dq_process_fg STRING(1) NOT NULL,
rp_process_fg STRING(1) NOT NULL,
update_timestamp DATETIME NOT NULL,
dq_last_processed_tmsp DATETIME,
rp_last_processed_tmsp DATETIME
);