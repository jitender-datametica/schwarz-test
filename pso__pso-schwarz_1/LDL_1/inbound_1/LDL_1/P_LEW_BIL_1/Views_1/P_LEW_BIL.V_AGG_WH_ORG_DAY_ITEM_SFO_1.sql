create or replace view LDL_PRODUCTION.P_LEW_BIL.V_AGG_WH_ORG_DAY_ITEM_SFO_1(
	CLIENT_ID,
	LOC_SID_WH,
	ASPECT_ID,
	BOOKING_DAT,
	CY_WEEK,
	CY_MONTH,
	ITEM_SID,
	SFOTYPE_ID,
	PCWO_REASON_ID,
	SFO_TOTAL_QTY,
	SFO_WRTOFF_ZERO_QTY,
	SFO_TOTAL_RTL_RL_VAL,
	SFO_TOTAL_RTL_RL_NET_VAL,
	SFO_WRTOFF_ZERO_RTL_RL_VAL,
	SFO_WRTOFF_ZERO_RTL_RL_NET_VAL,
	VAL_PR_DIFF_SFO,
	VAL_PR_DIFF_NET_SFO,
	SFO_TOTAL_FA_QTY,
	SFO_WRTOFF_ZERO_FA_QTY,
	SFO_TOTAL_RTL_RL_FA_VAL,
	SFO_TOTAL_RTL_RL_NET_FA_VAL,
	SFO_WRTOFF_ZERO_RTL_RL_FA_VAL,
	SFO_WRTOFF_ZERO_RTL_RL_NET_FA_VAL,
	VAL_PR_DIFF_FA_SFO,
	VAL_PR_DIFF_NET_FA_SFO,
	TIMESTAMP_MOD
) as
   SELECT
      client_id,
   loc_sid_wh_aspect1_asis                                                            AS loc_sid_wh,
   1::BYTEINT                                                                        AS aspect_id  -- Bges Sicht auf Basis Wawi/Lead 
   ,
   booking_dat,
   cy_week,
   cy_month,
   item_sid,
   sfotype_id,
   pcwo_reason_id,
   Sum(sfo_total_qty)                                                                 AS sfo_total_qty,
   Sum(sfo_wrtoff_zero_qty)                                                           AS sfo_wrtoff_zero_qty,
   Sum(sfo_total_rtl_rl_val)                                                          AS sfo_total_rtl_rl_val,
   Sum(sfo_total_rtl_rl_net_val)                                                      AS sfo_total_rtl_rl_net_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)                                                    AS sfo_wrtoff_zero_rtl_rl_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)                                                AS sfo_wrtoff_zero_rtl_rl_net_val,
   Sum(val_pr_diff_sfo)                                                               AS val_pr_diff_sfo,
   Sum(val_pr_diff_net_sfo)                                                           AS val_pr_diff_net_sfo,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_qty                  ELSE NULL END) AS sfo_total_fa_qty,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_qty            ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_val           ELSE NULL END) AS sfo_total_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_net_val       ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_val     ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_sfo                ELSE NULL END) AS val_pr_diff_fa_sfo,
   Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_sfo            ELSE NULL END) AS val_pr_diff_net_fa_sfo,
   Cast(Current_Timestamp AS TIMESTAMP)                                            AS timestamp_mod
   FROM p_lew_bil.t_agg_store_day_item_sfo_1
   WHERE aspect_id = 1
   GROUP BY
      client_id
     ,loc_sid_wh_aspect1_asis
     ,booking_dat
     ,cy_week
     ,cy_month
     ,item_sid
     ,sfotype_id
     ,pcwo_reason_id

   UNION ALL

   SELECT
      client_id,
   loc_sid_wh_aspect2_asis                                                            AS loc_sid_wh,
   2::BYTEINT                                                                        AS aspect_id  -- Vges Sicht auf Basis Wawi/Lead 
   ,
   booking_dat,
   cy_week,
   cy_month,
   item_sid,
   sfotype_id,
   pcwo_reason_id,
   Sum(sfo_total_qty)                                                                 AS sfo_total_qty,
   Sum(sfo_wrtoff_zero_qty)                                                           AS sfo_wrtoff_zero_qty,
   Sum(sfo_total_rtl_rl_val)                                                          AS sfo_total_rtl_rl_val,
   Sum(sfo_total_rtl_rl_net_val)                                                      AS sfo_total_rtl_rl_net_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)                                                    AS sfo_wrtoff_zero_rtl_rl_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)                                                AS sfo_wrtoff_zero_rtl_rl_net_val,
   Sum(val_pr_diff_sfo)                                                               AS val_pr_diff_sfo,
   Sum(val_pr_diff_net_sfo)                                                           AS val_pr_diff_net_sfo,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_qty                  ELSE NULL END) AS sfo_total_fa_qty,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_qty            ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_val           ELSE NULL END) AS sfo_total_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_net_val       ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_val     ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_sfo                ELSE NULL END) AS val_pr_diff_fa_sfo,
   Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_sfo            ELSE NULL END) AS val_pr_diff_net_fa_sfo,
   Cast(Current_Timestamp AS TIMESTAMP)                                            AS timestamp_mod
   FROM p_lew_bil.t_agg_store_day_item_sfo_1
   WHERE aspect_id = 2
   GROUP BY
      client_id
     ,loc_sid_wh_aspect2_asis
     ,booking_dat
     ,cy_week
     ,cy_month
     ,item_sid
     ,sfotype_id
     ,pcwo_reason_id
   ;
