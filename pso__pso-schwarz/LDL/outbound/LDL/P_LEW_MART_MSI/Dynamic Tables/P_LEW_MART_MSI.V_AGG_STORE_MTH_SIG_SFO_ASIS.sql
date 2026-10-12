CREATE OR REPLACE MATERIALIZED VIEW `_lew_mart_msi`.v_agg_store_mth_sig_sfo_asis
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.client_id,
 A.loc_sid_store AS store_id,
 A.src_orig_store_nr AS orig_store_nr,
 A.cy_month AS month_id,
 A.subitemgroup_id,
 A.sfotype_id,
 A.pcwo_reason_id,
 A.sfo_total_qty AS qty_total_sfo_asis,
  CASE
  WHEN A.sfotype_id IN (182, 192) AND A.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123,
       124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139,
       140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157) OR A.sfotype_id IN (137, 147) AND A.pcwo_reason_id
       IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152, 155) OR
     A.sfotype_id IN (181, 191) AND A.pcwo_reason_id IN (82, 83, 84)
  THEN A.sfo_total_qty
  ELSE NULL
  END AS qty_total_wtof_sfo_asis,
 A.sfo_wrtoff_zero_qty AS qty_total_sfo_wrtoff_zero_asis,
  A.sfo_total_rtl_rl_val / RFER.exchange_rate AS val_rtl_rcptline_sfo_asis,
  A.sfo_total_rtl_rl_net_val / RFER.exchange_rate AS val_rtl_rl_net_sfo_asis,
  A.sfo_wrtoff_zero_rtl_rl_val / RFER.exchange_rate AS val_wrtoff_zero_asis,
  A.sfo_wrtoff_zero_rtl_rl_net_val / RFER.exchange_rate AS val_wrtoff_zero_net_asis,
  A.val_pr_diff_sfo / RFER.exchange_rate AS val_pr_diff_sfo_asis,
  A.val_pr_diff_net_sfo / RFER.exchange_rate AS val_pr_diff_net_sfo_asis,
 A.sfo_total_fa_qty AS qty_total_fa_sfo_asis,
 A.sfo_wrtoff_zero_fa_qty AS qty_tot_sfo_wrtoff_zr_fa_asis,
  A.sfo_total_rtl_rl_fa_val / RFER.exchange_rate AS val_rtl_rcptline_fa_sfo_asis,
  A.sfo_total_rtl_rl_net_fa_val / RFER.exchange_rate AS val_rtl_rl_net_fa_sfo_asis,
  A.sfo_wrtoff_zero_rtl_rl_fa_val / RFER.exchange_rate AS val_wrtoff_zero_fa_asis,
  A.sfo_wrtoff_zero_rtl_rl_net_fa_val / RFER.exchange_rate AS val_wrtoff_zero_net_fa_asis,
  A.val_pr_diff_fa_sfo / RFER.exchange_rate AS val_pr_diff_fa_sfo_asis,
  A.val_pr_diff_net_fa_sfo / RFER.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 RFER.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_store_mth_sig_sfo_asis AS A
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate AS RFER ON A.client_id = RFER.client_id AND CURRENT_DATE
   BETWEEN RFER.active_from_dt AND RFER.active_to_dt;