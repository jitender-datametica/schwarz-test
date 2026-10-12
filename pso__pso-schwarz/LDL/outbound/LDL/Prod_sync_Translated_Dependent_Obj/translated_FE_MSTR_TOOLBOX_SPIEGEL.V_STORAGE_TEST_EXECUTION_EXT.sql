CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext (client_id, storage_test_exec_sid,
storage_test_exec_name, end_week, display_end_week, dur_week_cnt, min_training_day_cnt, spread_pct, test_name,
test_week_duration, test_status, filter_display_end_week) AS SELECT *
FROM ldl_fe_mstr_toolbox_spiegel.t_storage_test_execution_ext;