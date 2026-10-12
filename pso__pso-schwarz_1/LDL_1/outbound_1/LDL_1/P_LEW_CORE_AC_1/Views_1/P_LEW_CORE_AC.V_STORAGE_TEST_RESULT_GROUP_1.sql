CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_storage_test_result_group_1 AS SELECT storage_test_result_grp_sid,
 storage_test_result_grp_type_cd,
 loc_sid_store,
 test_week,
 item_grp_int_sid,
 sub_item_grp_sid,
 storage_test_promo_type_cd,
 user_defined_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_storage_test_result_group_1;