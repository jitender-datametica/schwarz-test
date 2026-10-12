CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_storage_test_missing_result_2 AS SELECT storage_test_exec_sid,
 storage_test_result_grp_sid,
 storage_test_metric_type_cd,
 reason_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_storage_test_missing_result_2;