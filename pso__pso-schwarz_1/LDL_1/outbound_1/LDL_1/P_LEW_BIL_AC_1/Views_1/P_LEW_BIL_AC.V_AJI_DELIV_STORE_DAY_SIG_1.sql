CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_aji_deliv_store_day_sig_1 (client_id, loc_sid_store, sub_item_grp_sid_asis,
dat_formdate, deliverytype_id, orig_store_nr, qty_total_del, val_rtl_rl_del, val_rtl_rl_net_del, qty_piece_del,
val_piece_del, val_piece_net_del, val_pr_diff_del, val_pr_diff_net_del, qty_total_fa_del, val_rtl_rl_fa_del,
val_rtl_rl_net_fa_del, qty_piece_fa_del, val_piece_fa_del, val_piece_net_fa_del, val_pr_diff_fa_del,
val_pr_diff_net_fa_del) AS SELECT *
FROM ldl_p_lew_bil.v_aji_deliv_store_day_sig_1;