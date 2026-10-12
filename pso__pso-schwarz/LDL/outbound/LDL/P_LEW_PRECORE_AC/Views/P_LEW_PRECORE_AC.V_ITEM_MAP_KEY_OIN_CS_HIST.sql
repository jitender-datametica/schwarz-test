CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_item_map_key_oin_cs_hist (client_id, item_sid, src_orig_item_nr,
src_case_size, dwh_valid_from, dwh_valid_to) AS SELECT client_id,
 item_sid,
 src_orig_item_nr,
 src_case_size,
 dwh_valid_from,
 dwh_valid_to
FROM ldl_p_lew_precore.t_item_map_key_oin_cs_hist;