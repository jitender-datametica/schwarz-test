CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_mdm_link (client_id, item_sid, client_item_role_cd, mdm_item_sid,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 client_item_role_cd,
 mdm_item_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_mdm_link;