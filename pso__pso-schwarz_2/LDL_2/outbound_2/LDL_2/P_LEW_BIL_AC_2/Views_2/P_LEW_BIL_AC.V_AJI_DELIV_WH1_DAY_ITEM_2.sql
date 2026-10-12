CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_aji_deliv_wh1_day_item_2 (client_id, loc_sid_wh_aspect1_asis, item_sid,
dat_formdate, cy_month, deliverytype_id, qty_total_del, val_rtl_rl_del, val_rtl_rl_net_del, qty_piece_del, val_piece_del
, val_piece_net_del, val_pr_diff_del, val_pr_diff_net_del, qty_total_fa_del, val_rtl_rl_fa_del, val_rtl_rl_net_fa_del,
qty_piece_fa_del, val_piece_fa_del, val_piece_net_fa_del, val_pr_diff_fa_del, val_pr_diff_net_fa_del) AS SELECT *
FROM ldl_p_lew_bil.v_aji_deliv_wh1_day_item_2;