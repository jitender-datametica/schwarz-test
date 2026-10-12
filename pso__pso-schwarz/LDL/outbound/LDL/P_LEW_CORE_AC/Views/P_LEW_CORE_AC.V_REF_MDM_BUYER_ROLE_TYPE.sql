CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_buyer_role_type (client_id, role_type_cd, role_type, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 role_type_cd,
 role_type,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_buyer_role_type;