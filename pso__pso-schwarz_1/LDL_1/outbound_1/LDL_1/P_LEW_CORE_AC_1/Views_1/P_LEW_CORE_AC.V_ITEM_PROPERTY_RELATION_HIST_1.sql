CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_property_relation_hist_1 (client_id, item_sid, item_property_sid,
deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 item_property_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_property_relation_hist_1;