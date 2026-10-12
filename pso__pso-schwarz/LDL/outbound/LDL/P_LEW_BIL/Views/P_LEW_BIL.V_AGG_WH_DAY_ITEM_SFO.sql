CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_wh_day_item_sfo AS SELECT client_id,
 loc_sid_wh_asis AS loc_sid_wh,
 CAST(MAX(1) AS BIGNUMERIC) AS aspect_id,
 booking_dat,
 cy_week,
 cy_month,
 item_sid,
 sfotype_id,
 pcwo_reason_id,
 SUM(sfo_total_qty) AS sfo_total_qty,
 SUM(sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,
 SUM(sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
 SUM(sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
 SUM(sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,
 SUM(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,
 SUM(val_pr_diff_sfo) AS val_pr_diff_sfo,
 SUM(val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_total_qty
   ELSE NULL
   END) AS sfo_total_fa_qty,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_wrtoff_zero_qty
   ELSE NULL
   END) AS sfo_wrtoff_zero_fa_qty,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_total_rtl_rl_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_fa_val,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_total_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_net_fa_val,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_wrtoff_zero_rtl_rl_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN sfo_wrtoff_zero_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN val_pr_diff_sfo
   ELSE NULL
   END) AS val_pr_diff_fa_sfo,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN val_pr_diff_net_sfo
   ELSE NULL
   END) AS val_pr_diff_net_fa_sfo,
 CURRENT_TIMESTAMP() AS timestamp_mod
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo
GROUP BY client_id,
 loc_sid_wh,
 booking_dat,
 cy_week,
 cy_month,
 item_sid,
 sfotype_id,
 pcwo_reason_id;