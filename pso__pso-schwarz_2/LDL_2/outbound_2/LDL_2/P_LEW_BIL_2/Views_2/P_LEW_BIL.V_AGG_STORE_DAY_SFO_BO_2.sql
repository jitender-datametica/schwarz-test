CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_store_day_sfo_bo_2 AS SELECT client_id,
 loc_sid_store,
 src_orig_store_nr,
 booking_dat,
 cy_month,
 sfotype_id,
 SUM(sfo_total_qty) AS sfo_total_qty,
 SUM(sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,
 SUM(sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
 SUM(sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
 SUM(sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,
 SUM(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_2
GROUP BY client_id,
 loc_sid_store,
 src_orig_store_nr,
 booking_dat,
 cy_month,
 sfotype_id;