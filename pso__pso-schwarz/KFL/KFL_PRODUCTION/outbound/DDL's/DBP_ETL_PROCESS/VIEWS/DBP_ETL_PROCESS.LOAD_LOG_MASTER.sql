CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.load_log_master (cycle_id, date_start, date_end, time_start,
time_end, status, user_id, process_id, cfg_file_name, env_file_name, job_name, comment_text, td_insert, td_update) AS
SELECT *
FROM kfl_production_dbp_process.load_log_master;