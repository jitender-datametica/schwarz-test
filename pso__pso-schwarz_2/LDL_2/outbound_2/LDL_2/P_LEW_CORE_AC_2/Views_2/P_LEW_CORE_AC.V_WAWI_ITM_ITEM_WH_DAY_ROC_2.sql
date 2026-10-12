CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_wh_day_roc_2 (client_id, wh_loc_sid, item_sid, dat_formdate,
stock_slot_fg, stock_case_size_fg, qty_piece_five_weeks_fg, qty_piece_vs_case_size_fg, qty_piece_stc_wh,
qty_total_goodsout_avg_35_days) AS SELECT client_id,
 wh_loc_sid,
 item_sid,
 dat_formdate,
 stock_slot_fg,
 stock_case_size_fg,
 qty_piece_five_weeks_fg,
 qty_piece_vs_case_size_fg,
 qty_piece_stc_wh,
 qty_total_goodsout_avg_35_days
FROM ldl_p_lew_core.t_wawi_itm_item_wh_day_roc_2;