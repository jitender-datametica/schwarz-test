CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_load_control_run_time_gtmp (script_start_tms, script_start_dt) AS SELECT
 script_start_tms,
 script_start_dt
FROM ldl_p_lew_process.t_load_control_run_time_gtmp;