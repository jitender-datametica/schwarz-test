create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_ITEM_SFO_ASIS_2(
	CLIENT_ID,
	STORE_ID,
	ORIG_STORE_NR,
	DAT_FORMDATE,
	CY_MONTH,
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
	PRICE_WH_SFO_ASIS,
	PRICE_WH_NET_SFO_ASIS,
	PRICE_STR_SFO_ASIS,
	PRICE_STR_NET_SFO_ASIS,
	VAL_PR_DIFF_SFO_ASIS,
	VAL_PR_DIFF_NET_SFO_ASIS,
	QTY_TOTAL_FA_SFO_ASIS,
	QTY_TOT_SFO_WRTOFF_ZR_FA_ASIS,
	VAL_RTL_RCPTLINE_FA_SFO_ASIS,
	VAL_RTL_RL_NET_FA_SFO_ASIS,
	VAL_WRTOFF_ZERO_FA_ASIS,
	VAL_WRTOFF_ZERO_NET_FA_ASIS,
	PRICE_WH_FA_SFO_ASIS,
	PRICE_WH_NET_FA_SFO_ASIS,
	PRICE_STR_FA_SFO_ASIS,
	PRICE_STR_NET_FA_SFO_ASIS,
	VAL_PR_DIFF_FA_SFO_ASIS,
	VAL_PR_DIFF_NET_FA_SFO_ASIS,
	CURRENCY_ISO_CD,
	SRC_FG
) as
   SELECT
  client_id
, store_id
, orig_store_nr
, dat_formdate
, cy_month
, item_id
, sfotype_id
, pcwo_reason_id
, qty_total_sfo_asis
, qty_total_wtof_sfo_asis
, qty_total_sfo_wrtoff_zero_asis
, val_rtl_rcptline_sfo_asis
, val_rtl_rl_net_sfo_asis
, val_wrtoff_zero_asis
, val_wrtoff_zero_net_asis
, price_wh_sfo_asis
, price_wh_net_sfo_asis
, price_str_sfo_asis
, price_str_net_sfo_asis
, val_pr_diff_sfo_asis
, val_pr_diff_net_sfo_asis
, qty_total_fa_sfo_asis
, qty_tot_sfo_wrtoff_zr_fa_asis
, val_rtl_rcptline_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis
, val_wrtoff_zero_fa_asis
, val_wrtoff_zero_net_fa_asis
, price_wh_fa_sfo_asis
, price_wh_net_fa_sfo_asis
, price_str_fa_sfo_asis
, price_str_net_fa_sfo_asis
, val_pr_diff_fa_sfo_asis
, val_pr_diff_net_fa_sfo_asis
, currency_iso_cd
, src_fg
   FROM p_lew_mart_msi.v_agg_store_day_item_sfo_asis_2
;
