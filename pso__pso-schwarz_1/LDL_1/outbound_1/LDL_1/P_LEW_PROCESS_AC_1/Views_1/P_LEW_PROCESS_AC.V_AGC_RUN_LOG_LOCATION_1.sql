CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agc_run_log_location_1 (run_log_sid, aggregate_name, client_id, dwh_cal_dt,
loc_sid, recalc_fg, status_1, run_id, run_cluster_cd, create_timestamp, update_timestamp, start_processing, end_processing
) AS SELECT *
FROM ldl_p_lew_process.v_agc_run_log_location_1;