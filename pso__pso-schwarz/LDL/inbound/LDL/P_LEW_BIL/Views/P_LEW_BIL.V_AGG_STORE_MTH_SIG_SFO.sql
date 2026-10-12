create or replace view LDL_PRODUCTION.P_LEW_BIL.V_AGG_STORE_MTH_SIG_SFO(
	CLIENT_ID,
	LOC_SID_STORE,
	SRC_ORIG_STORE_NR,
	CY_MONTH,
	SUB_ITEM_GRP_SID,
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
   loc_sid_store,
   src_orig_store_nr,
   cy_month,
   sub_item_grp_sid_asis                                                                 AS sub_item_grp_sid,
   sfotype_id,
   pcwo_reason_id,
   Sum(sfo_total_qty )                                                                   AS sfo_total_qty,
   Sum(sfo_wrtoff_zero_qty)                                                              AS sfo_wrtoff_zero_qty,
   Sum(sfo_total_rtl_rl_val)                                                             AS sfo_total_rtl_rl_val,
   Sum(sfo_total_rtl_rl_net_val)                                                         AS sfo_total_rtl_rl_net_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)                                                       AS sfo_wrtoff_zero_rtl_rl_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)                                                   AS sfo_wrtoff_zero_rtl_rl_net_val,
   Sum(val_pr_diff_sfo)                                                                  AS val_pr_diff_sfo,
   Sum(val_pr_diff_net_sfo)                                                              AS val_pr_diff_net_sfo,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_qty                  ELSE NULL END) AS sfo_total_fa_qty,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_qty            ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_rtl_rl_val           ELSE NULL END) AS sfo_total_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_rtl_rl_net_val       ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_rtl_rl_val     ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN val_pr_diff_sfo                ELSE NULL END) AS val_pr_diff_fa_sfo,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN val_pr_diff_net_sfo            ELSE NULL END) AS val_pr_diff_net_fa_sfo,
   Cast(Current_Timestamp AS TIMESTAMP)                                               AS timestamp_mod
   FROM p_lew_bil.t_agg_store_day_item_sfo

   GROUP BY
      client_id
     ,loc_sid_store
     ,src_orig_store_nr
     ,cy_month
     ,sub_item_grp_sid
     ,sfotype_id
     ,pcwo_reason_id
;
