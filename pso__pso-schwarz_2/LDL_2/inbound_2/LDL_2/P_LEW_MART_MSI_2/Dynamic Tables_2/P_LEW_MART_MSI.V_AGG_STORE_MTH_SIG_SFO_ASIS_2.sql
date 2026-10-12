create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_AGG_STORE_MTH_SIG_SFO_ASIS_2(
	CLIENT_ID,
	STORE_ID,
	ORIG_STORE_NR,
	MONTH_ID,
	SUBITEMGROUP_ID,
	SFOTYPE_ID,
	PCWO_REASON_ID,
	QTY_TOTAL_SFO_ASIS,
	QTY_TOTAL_WTOF_SFO_ASIS,
	QTY_TOTAL_SFO_WRTOFF_ZERO_ASIS,
	VAL_RTL_RCPTLINE_SFO_ASIS,
	VAL_RTL_RL_NET_SFO_ASIS,
	VAL_WRTOFF_ZERO_ASIS,
	VAL_WRTOFF_ZERO_NET_ASIS,
	VAL_PR_DIFF_SFO_ASIS,
	VAL_PR_DIFF_NET_SFO_ASIS,
	QTY_TOTAL_FA_SFO_ASIS,
	QTY_TOT_SFO_WRTOFF_ZR_FA_ASIS,
	VAL_RTL_RCPTLINE_FA_SFO_ASIS,
	VAL_RTL_RL_NET_FA_SFO_ASIS,
	VAL_WRTOFF_ZERO_FA_ASIS,
	VAL_WRTOFF_ZERO_NET_FA_ASIS,
	VAL_PR_DIFF_FA_SFO_ASIS,
	VAL_PR_DIFF_NET_FA_SFO_ASIS,
	CURRENCY_ISO_CD
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_MSI
 as
      SELECT a.client_id
   , a.loc_sid_store AS store_id
   , a.src_orig_store_nr AS orig_store_nr
   , a.cy_month AS month_id
   , a.subitemgroup_id
   , a.sfotype_id
   , a.pcwo_reason_id
   , a.sfo_total_qty AS qty_total_sfo_asis
   , CASE WHEN (a.sfotype_id IN (182, 192)
       AND a.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157))
       OR (a.sfotype_id IN (137, 147)
       AND a.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152, 155))
       OR (a.sfotype_id IN (181, 191)
       AND a.pcwo_reason_id IN (82, 83, 84)) 
       THEN a.sfo_total_qty ELSE NULL END                     AS qty_total_wtof_sfo_asis
   , a.sfo_wrtoff_zero_qty AS qty_total_sfo_wrtoff_zero_asis
   , a.sfo_total_rtl_rl_val / rfer.exchange_rate AS val_rtl_rcptline_sfo_asis
   , a.sfo_total_rtl_rl_net_val / rfer.exchange_rate  AS val_rtl_rl_net_sfo_asis
   , a.sfo_wrtoff_zero_rtl_rl_val / rfer.exchange_rate AS val_wrtoff_zero_asis
   , a.sfo_wrtoff_zero_rtl_rl_net_val / rfer.exchange_rate AS val_wrtoff_zero_net_asis
   , a.val_pr_diff_sfo / rfer.exchange_rate AS val_pr_diff_sfo_asis
   , a.val_pr_diff_net_sfo / rfer.exchange_rate AS val_pr_diff_net_sfo_asis
   , a.sfo_total_fa_qty AS qty_total_fa_sfo_asis
   , a.sfo_wrtoff_zero_fa_qty AS qty_tot_sfo_wrtoff_zr_fa_asis
   , a.sfo_total_rtl_rl_fa_val / rfer.exchange_rate AS val_rtl_rcptline_fa_sfo_asis
   , a.sfo_total_rtl_rl_net_fa_val / rfer.exchange_rate AS val_rtl_rl_net_fa_sfo_asis
   , a.sfo_wrtoff_zero_rtl_rl_fa_val / rfer.exchange_rate AS val_wrtoff_zero_fa_asis
   , a.sfo_wrtoff_zero_rtl_rl_net_fa_val / rfer.exchange_rate AS val_wrtoff_zero_net_fa_asis
   , a.val_pr_diff_fa_sfo / rfer.exchange_rate AS val_pr_diff_fa_sfo_asis
   , a.val_pr_diff_net_fa_sfo / rfer.exchange_rate AS val_pr_diff_net_fa_sfo_asis
   , rfer.curr_cd_from AS currency_iso_cd
  FROM p_lew_bil_ac.v_agg_store_mth_sig_sfo_asis_2 AS a
   INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate_2 AS rfer
   ON a.client_id = rfer.client_id
   AND Current_Date BETWEEN rfer.active_from_dt AND rfer.active_to_dt
;
