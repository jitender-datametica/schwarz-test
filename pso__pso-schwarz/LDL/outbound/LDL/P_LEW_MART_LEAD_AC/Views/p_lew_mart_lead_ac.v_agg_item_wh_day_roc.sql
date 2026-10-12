CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_item_wh_day_roc (client_id, wh_loc_sid, wh_id, aspect_id,
currency_iso_cd, item_sid, dat_formdate, cy_week, cy_month, busyear, stock_slot_fg, stock_case_size_fg,
qty_piece_five_weeks_fg, qty_piece_vs_case_size_fg, flags_combined, qty_piece_stc_wh, qty_total_goodsout_avg_35_days) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_agg_item_wh_day_roc;