CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_storage_test_parameter_2 AS SELECT storage_test_exec_sid,
 storage_test_result_grp_sid,
 storage_test_param_type_cd,
 param_txt,
 param_pct,
 param_meas,
 param_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_storage_test_parameter_2;