CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_export_log_lago (
load_id BIGNUMERIC(38,0) NOT NULL,
export_cluster_id BIGNUMERIC(38,0) DEFAULT 1,
process_name STRING(100) COLLATE 'und:ci' NOT NULL,
report_dt DATE NOT NULL,
report_days BIGNUMERIC(38,0) NOT NULL,
report_mode STRING(20) COLLATE 'und:ci' NOT NULL,
start_tmsp DATETIME NOT NULL,
end_tmsp DATETIME NOT NULL,
max_load_id BIGNUMERIC(38,0) NOT NULL,
max_timestamp_delta DATETIME,
data_count BIGNUMERIC(38,0) NOT NULL,
status STRING(20) COLLATE 'und:ci' NOT NULL,
log_descr STRING(1000) COLLATE 'und:ci'
);