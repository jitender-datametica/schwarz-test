CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_list_type (mdm_list_type_cd, mdm_list_type_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT mdm_list_type_cd,
 mdm_list_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_list_type;