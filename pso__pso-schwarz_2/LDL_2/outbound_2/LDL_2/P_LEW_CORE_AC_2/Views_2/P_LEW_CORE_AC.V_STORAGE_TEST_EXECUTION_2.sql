CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_storage_test_execution_2 AS SELECT client_id,
 storage_test_exec_sid,
 storage_test_exec_name,
 end_week,
 dur_week_cnt,
 min_training_day_cnt,
 spread_pct,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_storage_test_execution_2;