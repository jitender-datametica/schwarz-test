CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_sort_box_hist (client_id, item_sid_sort_box, item_sid, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid_sort_box,
 item_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_sort_box_hist;