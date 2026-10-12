CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_item_map_key_oin_wh_hist_1 (client_id, src_orig_item_nr, src_orig_wh_nr,
item_sid, loc_sid_wh, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 src_orig_item_nr,
 src_orig_wh_nr,
 item_sid,
 loc_sid_wh,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_item_map_key_oin_wh_hist_1;