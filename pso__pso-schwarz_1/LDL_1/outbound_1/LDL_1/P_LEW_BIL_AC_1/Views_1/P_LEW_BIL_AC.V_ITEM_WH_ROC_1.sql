CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_item_wh_roc_1 AS SELECT client_id,
 loc_sid,
 item_sid,
 stock_slot_fg,
 stock_case_size_fg,
 qty_piece_five_weeks_fg,
 qty_piece_vs_case_size_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_created
FROM ldl_p_lew_bil.t_item_wh_roc_1;