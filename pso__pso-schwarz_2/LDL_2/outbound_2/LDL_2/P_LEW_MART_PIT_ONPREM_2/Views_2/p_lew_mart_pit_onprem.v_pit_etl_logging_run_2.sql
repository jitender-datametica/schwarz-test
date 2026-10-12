CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_etl_logging_run_2 (run_id, run_ts, run_dt) AS SELECT run_id,
 run_ts,
 run_dt
FROM ldl_p_lew_mart_pit_onprem.t_pit_etl_logging_run_2;