CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_delivery_hist_2 (client_id, mdm_item_sid, item_del_seq,
cy_week_item_del, dwh_valid_from, dwh_valid_to, deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 item_del_seq,
 cy_week_item_del,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_delivery_hist_2;