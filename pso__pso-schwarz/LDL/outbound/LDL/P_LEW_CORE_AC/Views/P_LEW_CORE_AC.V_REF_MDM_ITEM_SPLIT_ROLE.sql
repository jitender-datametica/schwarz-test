CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_split_role (mdm_item_split_role_cd, mdm_item_split_role_name,
mdm_item_split_role_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT mdm_item_split_role_cd,
 mdm_item_split_role_name,
 mdm_item_split_role_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_split_role;