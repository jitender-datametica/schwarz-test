CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_day_sig_sfo_1 (client_id, loc_sid_store, src_orig_store_nr,
booking_dat, cy_week, cy_month, sub_item_grp_sid, sfotype_id, pcwo_reason_id, sfo_total_qty, sfo_wrtoff_zero_qty,
sfo_total_rtl_rl_val, sfo_total_rtl_rl_net_val, sfo_wrtoff_zero_rtl_rl_val, sfo_wrtoff_zero_rtl_rl_net_val,
val_pr_diff_sfo, val_pr_diff_net_sfo, sfo_total_fa_qty, sfo_wrtoff_zero_fa_qty, sfo_total_rtl_rl_fa_val,
sfo_total_rtl_rl_net_fa_val, sfo_wrtoff_zero_rtl_rl_fa_val, sfo_wrtoff_zero_rtl_rl_net_fa_val, val_pr_diff_fa_sfo,
val_pr_diff_net_fa_sfo, timestamp_mod) AS SELECT *
FROM ldl_p_lew_bil.v_agg_store_day_sig_sfo_1;