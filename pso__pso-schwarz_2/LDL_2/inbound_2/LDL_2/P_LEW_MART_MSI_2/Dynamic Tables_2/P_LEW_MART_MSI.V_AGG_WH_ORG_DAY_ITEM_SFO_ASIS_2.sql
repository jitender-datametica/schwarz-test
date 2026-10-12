create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_AGG_WH_ORG_DAY_ITEM_SFO_ASIS_2(
	CLIENT_ID,
	WH_ID,
	ASPECT_ID,
	DAT_FORMDATE,
	ITEM_ID,
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
  SELECT
      agg.client_id
   , wh.src_wh_id AS wh_id
   , agg.aspect_id
   , agg.booking_dat                                AS dat_formdate
   , itmp.item_sid_map                              AS item_id
   , agg.sfotype_id
   , agg.pcwo_reason_id
   , agg.sfo_total_qty_asis                         AS qty_total_sfo_asis
   , CASE WHEN (agg.sfotype_id IN (182, 192)
       AND agg.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157))
       OR (agg.sfotype_id IN (137, 147)
       AND agg.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152, 155))
       OR (agg.sfotype_id IN (181, 191)
       AND agg.pcwo_reason_id IN (82, 83, 84)) 
       THEN agg.sfo_total_qty_asis ELSE NULL END    AS qty_total_wtof_sfo_asis
   , agg.sfo_wrtoff_zero_qty_asis                   AS qty_total_sfo_wrtoff_zero_asis
   , agg.sfo_total_rtl_rl_val_asis                  AS val_rtl_rcptline_sfo_asis
   , agg.sfo_total_rtl_rl_net_val_asis              AS val_rtl_rl_net_sfo_asis
   , agg.sfo_wrtoff_zero_rtl_rl_val_asis            AS val_wrtoff_zero_asis
   , agg.sfo_wrtoff_zero_rtl_rl_net_val_asis        AS val_wrtoff_zero_net_asis
   , agg.val_pr_diff_sfo_asis                       
   , agg.val_pr_diff_net_sfo_asis                   
   , agg.sfo_total_fa_qty_asis                      AS qty_total_fa_sfo_asis
   , agg.sfo_wrtoff_zero_fa_qty_asis                AS qty_tot_sfo_wrtoff_zr_fa_asis
   , agg.sfo_total_rtl_rl_fa_val_asis               AS val_rtl_rcptline_fa_sfo_asis
   , agg.sfo_total_rtl_rl_net_fa_val_asis           AS val_rtl_rl_net_fa_sfo_asis
   , agg.sfo_wrtoff_zero_rtl_rl_fa_val_asis         AS val_wrtoff_zero_fa_asis
   , agg.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis     AS val_wrtoff_zero_net_fa_asis
   , agg.val_pr_diff_fa_sfo_asis
   , agg.val_pr_diff_net_fa_sfo_asis
   , agg.curr_cd_from                               AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_wh_org_day_item_sfo_asis_2 AS agg

   JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON agg.client_id=wh.client_id
   AND agg.loc_sid_wh=wh.loc_sid_wh
     AND wh.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid
;
