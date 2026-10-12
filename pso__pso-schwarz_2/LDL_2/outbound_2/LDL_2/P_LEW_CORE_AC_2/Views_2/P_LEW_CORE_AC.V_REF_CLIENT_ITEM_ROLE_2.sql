CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_client_item_role_2 (client_system, client_item_role_cd, client_item_role,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_system,
 client_item_role_cd,
 client_item_role,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_client_item_role_2;