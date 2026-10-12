CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_day_sfo_bo_1 (client_id, loc_sid_store, src_orig_store_nr, booking_dat
, cy_month, sfotype_id, sfo_total_qty, sfo_wrtoff_zero_qty, sfo_total_rtl_rl_val, sfo_total_rtl_rl_net_val,
sfo_wrtoff_zero_rtl_rl_val, sfo_wrtoff_zero_rtl_rl_net_val) AS SELECT *
FROM ldl_p_lew_bil.v_agg_store_day_sfo_bo_1;