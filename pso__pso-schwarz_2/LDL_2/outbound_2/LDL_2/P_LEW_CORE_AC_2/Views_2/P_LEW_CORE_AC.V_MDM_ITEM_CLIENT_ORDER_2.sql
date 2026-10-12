CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_client_order_2 (client_id, mdm_item_sid, client_id_order, int_org_sid
, client_cd, client_block_id_order, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 client_id_order,
 int_org_sid,
 client_cd,
 client_block_id_order,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_client_order_2;