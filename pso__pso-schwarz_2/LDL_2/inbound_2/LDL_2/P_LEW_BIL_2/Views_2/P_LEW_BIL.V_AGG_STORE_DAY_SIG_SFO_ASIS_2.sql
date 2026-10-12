create or replace view LDL_PRODUCTION.P_LEW_BIL.V_AGG_STORE_DAY_SIG_SFO_ASIS_2(
	CLIENT_ID,
	LOC_SID_STORE,
	SRC_ORIG_STORE_NR,
	BOOKING_DAT,
	SUBITEMGROUP_ID,
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
	VAL_PR_DIFF_NET_FA_SFO
) as
   SELECT
      agg.client_id,
   agg.loc_sid_store,
   agg.src_orig_store_nr,
   agg.booking_dat,
   CAST(suig.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id,
   agg.sfotype_id,
   agg.pcwo_reason_id,
   agg.sfo_total_qty,
   agg.sfo_wrtoff_zero_qty,
   agg.sfo_total_rtl_rl_val,
   agg.sfo_total_rtl_rl_net_val,
   agg.sfo_wrtoff_zero_rtl_rl_val,
   agg.sfo_wrtoff_zero_rtl_rl_net_val,
   agg.val_pr_diff_sfo,
   agg.val_pr_diff_net_sfo,
   agg.sfo_total_fa_qty,
   agg.sfo_wrtoff_zero_fa_qty,
   agg.sfo_total_rtl_rl_fa_val,
   agg.sfo_total_rtl_rl_net_fa_val,
   agg.sfo_wrtoff_zero_rtl_rl_fa_val,
   agg.sfo_wrtoff_zero_rtl_rl_net_fa_val,
   agg.val_pr_diff_fa_sfo,
   agg.val_pr_diff_net_fa_sfo
   FROM p_lew_bil.v_agg_store_day_sig_sfo_2 AS agg
   INNER JOIN p_lew_core_ac.v_subitemgroup_2 suig
   ON agg.client_id = suig.client_id
   AND agg.sub_item_grp_sid = suig.sub_item_grp_sid
   ;
