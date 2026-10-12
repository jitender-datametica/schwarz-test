CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_item_wh_day_roc_2 (client_id, wh_loc_sid, wh_id, aspect_id,
currency_iso_cd, item_sid, dat_formdate, cy_week, cy_month, busyear, stock_slot_fg, stock_case_size_fg,
qty_piece_five_weeks_fg, qty_piece_vs_case_size_fg, flags_combined, qty_piece_stc_wh, qty_total_goodsout_avg_35_days) AS
SELECT AGG.client_id,
 AGG.wh_loc_sid,
 AGG.wh_id,
 AGG.aspect_id,
 CRY.curr_cd_from AS currency_iso_cd,
 AGG.item_sid,
 AGG.dat_formdate,
 AGG.cy_week,
 AGG.cy_month,
 AGG.busyear,
 AGG.stock_slot_fg,
 AGG.stock_case_size_fg,
 AGG.qty_piece_five_weeks_fg,
 AGG.qty_piece_vs_case_size_fg,
 AGG.flags_combined,
 AGG.qty_piece_stc_wh,
 AGG.qty_total_goodsout_avg_35_days
FROM ldl_p_lew_mart_lead.t_agg_item_wh_day_roc_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';