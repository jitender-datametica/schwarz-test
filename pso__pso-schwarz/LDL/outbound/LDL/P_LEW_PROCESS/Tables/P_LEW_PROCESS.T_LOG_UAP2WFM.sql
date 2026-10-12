CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_log_uap2wfm (
proj_name STRING(10) COLLATE 'und:ci' NOT NULL,
hive_table_name STRING(50) COLLATE 'und:ci' NOT NULL,
date_partkey DATE NOT NULL,
daily_run_counter INTEGER NOT NULL,
last_upd_timestamp DATETIME NOT NULL,
uap_cluster STRING(2) COLLATE 'und:ci' NOT NULL,
wfm_env_name STRING(4) COLLATE 'und:ci' NOT NULL
);