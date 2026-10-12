CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_type (client_id, item_type_sid, src_mtart, item_type_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 item_type_sid,
 src_mtart,
 item_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_type;