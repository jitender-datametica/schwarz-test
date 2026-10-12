CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_store_group_type_2 (store_grp_type_cd, store_grp_type_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT store_grp_type_cd,
 store_grp_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_store_group_type_2;