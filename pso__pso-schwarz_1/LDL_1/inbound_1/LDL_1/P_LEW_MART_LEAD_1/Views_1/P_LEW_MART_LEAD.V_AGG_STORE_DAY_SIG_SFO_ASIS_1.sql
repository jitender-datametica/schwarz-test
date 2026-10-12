create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_STORE_DAY_SIG_SFO_ASIS_1(
	CLIENT_ID,
	STORE_ID,
	ORIG_STORE_NR,
	DAT_FORMDATE,
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
) as
   SELECT agg.client_id
   , agg.loc_sid_store AS store_id
   , agg.src_orig_store_nr AS orig_store_nr
   , agg.booking_dat AS dat_formdate
   , agg.subitemgroup_id
   , agg.sfotype_id
   , agg.pcwo_reason_id
   , agg.sfo_total_qty AS qty_total_sfo_asis
   , CASE WHEN (agg.sfotype_id IN (182, 192)
       AND agg.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157))
       OR (agg.sfotype_id IN (137, 147)
       AND agg.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152, 155))
       OR (agg.sfotype_id IN (181, 191)
       AND agg.pcwo_reason_id IN (82, 83, 84)) 
       THEN agg.sfo_total_qty ELSE NULL END                     AS qty_total_wtof_sfo_asis
   , agg.sfo_wrtoff_zero_qty AS qty_total_sfo_wrtoff_zero_asis
   , agg.sfo_total_rtl_rl_val / cry.exchange_rate AS val_rtl_rcptline_sfo_asis
   , agg.sfo_total_rtl_rl_net_val / cry.exchange_rate AS val_rtl_rl_net_sfo_asis
   , agg.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate AS val_wrtoff_zero_asis
   , agg.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate AS val_wrtoff_zero_net_asis
   , agg.val_pr_diff_sfo / cry.exchange_rate AS val_pr_diff_sfo_asis
   , agg.val_pr_diff_net_sfo / cry.exchange_rate AS val_pr_diff_net_sfo_asis
   , agg.sfo_total_fa_qty AS qty_total_fa_sfo_asis
   , agg.sfo_wrtoff_zero_fa_qty AS qty_tot_sfo_wrtoff_zr_fa_asis
   , agg.sfo_total_rtl_rl_fa_val / cry.exchange_rate AS val_rtl_rcptline_fa_sfo_asis
   , agg.sfo_total_rtl_rl_net_fa_val / cry.exchange_rate AS val_rtl_rl_net_fa_sfo_asis
   , agg.sfo_wrtoff_zero_rtl_rl_fa_val / cry.exchange_rate AS val_wrtoff_zero_fa_asis
   , agg.sfo_wrtoff_zero_rtl_rl_net_fa_val / cry.exchange_rate AS val_wrtoff_zero_net_fa_asis
   , agg.val_pr_diff_fa_sfo / cry.exchange_rate AS val_pr_diff_fa_sfo_asis
   , agg.val_pr_diff_net_fa_sfo / cry.exchange_rate AS val_pr_diff_net_fa_sfo_asis
   , cry.curr_cd_from AS currency_iso_cd
  FROM p_lew_bil_ac.v_agg_store_day_sig_sfo_asis_1 AS agg
   INNER JOIN (SELECT  xr_kn_h.client_id
   , xrtyp.src_kurst
   , xr_kn_h.curr_cd_from
   , xr_kn_h.curr_cd_to
   , xr_kn_h.curr_sid_from
   , xr_kn_h.curr_sid_to
   , xr_kn_h.exchange_rate
   , xr_kn_h.active_from_dt
   , xr_kn_h.active_to_dt
   , xr_kn_h.deleted_fg
                   FROM p_lew_core_ac.v_exchange_rate_known_hist_1 xr_kn_h
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 xrtyp
   ON xr_kn_h.client_id=xrtyp.client_id
   AND xr_kn_h.x_rate_type_sid=xrtyp.x_rate_type_sid

WHERE 
 CURRENT_DATE BETWEEN xr_kn_h.dwh_valid_from AND xr_kn_h.dwh_valid_to
 
 AND xrtyp.src_kurst='@BEWE') cry
   ON agg.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
;
