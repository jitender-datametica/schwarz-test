CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_export_log_lago (load_id, export_cluster_id, process_name, report_dt,
report_days, report_mode, start_tmsp, end_tmsp, max_load_id, max_timestamp_delta, data_count, status, log_descr) AS
SELECT load_id,
 export_cluster_id,
 process_name,
 report_dt,
 report_days,
 report_mode,
 start_tmsp,
 end_tmsp,
 max_load_id,
 max_timestamp_delta,
 data_count,
 status,
 log_descr
FROM ldl_p_lew_process.t_export_log_lago;