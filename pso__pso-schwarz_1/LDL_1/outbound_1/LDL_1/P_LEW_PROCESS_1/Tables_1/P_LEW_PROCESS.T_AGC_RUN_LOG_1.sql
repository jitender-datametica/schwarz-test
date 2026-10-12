CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agc_run_log_1 (
run_log_sid BIGNUMERIC(38,0) NOT NULL,
aggregate_name STRING(100) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
recalc_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
status_1 STRING(100) COLLATE 'und:ci' NOT NULL,
run_id BIGNUMERIC(38,0) NOT NULL,
run_cluster_cd STRING(15) COLLATE 'und:ci' NOT NULL,
create_timestamp DATETIME NOT NULL,
update_timestamp DATETIME,
start_processing DATETIME,
end_processing DATETIME,
PRIMARY KEY (run_log_sid, client_id, dwh_cal_dt, recalc_fg, run_id) NOT ENFORCED
);