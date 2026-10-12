CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_storage_test_store_relation_1 AS SELECT storage_test_exec_sid,
 loc_sid_store,
 rel_loc_sid_store,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_storage_test_store_relation_1;