CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_log_uap2wfm (proj_name, hive_table_name, date_partkey, daily_run_counter,
last_upd_timestamp, uap_cluster, wfm_env_name) AS SELECT proj_name,
 hive_table_name,
 date_partkey,
 daily_run_counter,
 last_upd_timestamp,
 uap_cluster,
 wfm_env_name
FROM ldl_p_lew_process.t_log_uap2wfm;