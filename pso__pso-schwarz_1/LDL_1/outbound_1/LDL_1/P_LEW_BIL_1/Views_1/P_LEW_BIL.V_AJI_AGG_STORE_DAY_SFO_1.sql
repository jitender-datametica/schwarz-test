CREATE OR REPLACE VIEW ldl_p_lew_bil.v_aji_agg_store_day_sfo_1 AS SELECT client_id,
 loc_sid_store,
 src_orig_store_nr,
 booking_dat,
 cy_month,
 sfotype_id,
 pcwo_reason_id,
 SUM(sfo_total_qty) AS sfo_total_qty_asis,
 SUM(sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty_asis,
 SUM(sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val_asis,
 SUM(sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val_asis,
 SUM(sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val_asis,
 SUM(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
 SUM(val_pr_diff_sfo) AS val_pr_diff_sfo_asis,
 SUM(val_pr_diff_net_sfo) AS val_pr_diff_net_sfo_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_total_qty
   ELSE NULL
   END) AS sfo_total_fa_qty_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_wrtoff_zero_qty
   ELSE NULL
   END) AS sfo_wrtoff_zero_fa_qty_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_total_rtl_rl_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_fa_val_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_total_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_net_fa_val_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_wrtoff_zero_rtl_rl_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN sfo_wrtoff_zero_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN val_pr_diff_sfo
   ELSE NULL
   END) AS val_pr_diff_fa_sfo_asis,
 SUM(CASE
   WHEN foodaction_fg_asis = 1
   THEN val_pr_diff_net_sfo
   ELSE NULL
   END) AS val_pr_diff_net_fa_sfo_asis,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS timestamp_mod
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1 AS AGG
GROUP BY client_id,
 loc_sid_store,
 src_orig_store_nr,
 booking_dat,
 cy_month,
 sfotype_id,
 pcwo_reason_id;