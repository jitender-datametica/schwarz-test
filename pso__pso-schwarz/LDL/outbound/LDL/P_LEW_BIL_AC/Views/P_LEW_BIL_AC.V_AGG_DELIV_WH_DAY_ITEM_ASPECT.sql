CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_deliv_wh_day_item_aspect (client_id, src_wh_id, item_sid, dat_formdate,
deliverytype_id, aspect_id, qty_total_del, val_rtl_rl_del, val_rtl_rl_net_del, qty_piece_del, val_piece_del,
val_piece_net_del, val_pr_diff_del, val_pr_diff_net_del, qty_total_fa_del, val_rtl_rl_fa_del, val_rtl_rl_net_fa_del,
qty_piece_fa_del, val_piece_fa_del, val_piece_net_fa_del, val_pr_diff_fa_del, val_pr_diff_net_fa_del) AS SELECT *
FROM ldl_p_lew_bil.v_agg_deliv_wh_day_item_aspect;