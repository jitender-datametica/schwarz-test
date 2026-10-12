CREATE OR REPLACE VIEW kfl_production_dbp_v_process.v_load_log_master_1 AS SELECT cycle_id,
 date_start,
 date_end,
 time_start,
 time_end,
 status_1,
 user_id,
 process_id,
 cfg_file_name,
 env_file_name,
 job_name,
 comment_text
FROM kfl_production_dbp_process.load_log_master_1;