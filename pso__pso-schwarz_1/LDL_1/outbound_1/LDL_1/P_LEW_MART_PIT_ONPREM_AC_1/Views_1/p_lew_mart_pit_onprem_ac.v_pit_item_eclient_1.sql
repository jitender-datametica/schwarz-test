CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_item_eclient_1 (effective_client_id, item_sid, client_id,
luxembourg_fg, lang_sid, item_mstr_sid, orig_item_nr, case_size, dat_valid_from, item_name, item_description) AS SELECT
 effective_client_id,
 item_sid,
 client_id,
 luxembourg_fg,
 lang_sid,
 item_mstr_sid,
 orig_item_nr,
 case_size,
 dat_valid_from,
 item_name,
 item_description
FROM ldl_p_lew_mart_pit_onprem.t_pit_item_eclient_1 AS IC;