CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_packing_list_pos_hist_2 (client_id, mdm_pack_list_sid,
mdm_item_set_sid, mdm_item_size_sid, pack_list_pos_version, pack_list_pos_priority, pack_list_pos_req_qty,
pack_list_pos_pack_qty, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 mdm_pack_list_sid,
 mdm_item_set_sid,
 mdm_item_size_sid,
 pack_list_pos_version,
 pack_list_pos_priority,
 pack_list_pos_req_qty,
 pack_list_pos_pack_qty,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_packing_list_pos_hist_2;