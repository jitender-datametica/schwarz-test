CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_item_inv_all (client_id, store_id, inv_id, cy_month, dat_valid_from
, dat_valid_until, item_id, val_rtl_ejr, val_rtl_net_ejr, val_return_ejr, val_return_net_ejr, qty_piece_ejr,
qty_return_ejr, diff_inv_stc_calc_cnt, diff_inv_stc_calc_price_avg, diff_inv_stc_calc_prc_avg_net, diff_inv_stc_calc_val
, diff_inv_stc_calc_val_net, diff_inv_stc_calc_val_net_diff, val_abs, val_net_abs, val_pr_diff_del, val_pr_diff_net_del
, val_pr_diff_return, val_pr_diff_net_return, val_pv, val_net_pv, val_claim, val_claim_net, val_rtl_fa_ejr,
val_rtl_net_fa_ejr, val_return_fa_ejr, val_return_net_fa_ejr, qty_piece_fa_ejr, qty_return_fa_ejr,
diff_inv_stc_calc_cnt_fa, diff_inv_stc_calc_val_fa, diff_inv_stc_calc_val_net_fa, val_abs_fa, val_net_abs_fa,
val_pr_diff_fa_del, val_pr_diff_net_fa_del, val_pr_diff_fa_return, val_pr_diff_net_fa_return, val_pv_fa, val_net_pv_fa,
val_claim_fa, val_claim_net_fa) AS SELECT *
FROM ldl_p_lew_bil.v_agg_store_item_inv_all;