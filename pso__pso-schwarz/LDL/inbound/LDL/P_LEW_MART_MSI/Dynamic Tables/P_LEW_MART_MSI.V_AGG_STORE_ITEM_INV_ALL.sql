CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STORE_ITEM_INV_ALL
/*
#DescStart#
#$Revision: 8320 $, $LastChangedBy: mueding $
#SubjectAreas#: Inventuren
#DescEnd# 
* */
(
	client_id
,	store_id
,	inv_id
,	cy_month
,	dat_valid_from
,	dat_valid_until
,	item_id
,	val_rtl_ejr
,	val_rtl_net_ejr
,	val_return_ejr
,	val_return_net_ejr
,	qty_piece_ejr
,	qty_return_ejr
,	diff_inv_stc_calc_cnt
,	diff_inv_stc_calc_price_avg
,	diff_inv_stc_calc_prc_avg_net
,	diff_inv_stc_calc_val
,	diff_inv_stc_calc_val_net
,	diff_inv_stc_calc_val_net_diff
,	val_abs
,	val_net_abs
,	val_pr_diff_del
,	val_pr_diff_net_del
,	val_pr_diff_return
,	val_pr_diff_net_return
,	val_pv
,	val_net_pv
,	val_claim
,	val_claim_net
,	val_rtl_fa_ejr
,	val_rtl_net_fa_ejr
,	val_return_fa_ejr
,	val_return_net_fa_ejr
,	qty_piece_fa_ejr
,	qty_return_fa_ejr
,	diff_inv_stc_calc_cnt_fa
,	diff_inv_stc_calc_val_fa
,	diff_inv_stc_calc_val_net_fa
,	val_abs_fa
,	val_net_abs_fa
,	val_pr_diff_fa_del
,	val_pr_diff_net_fa_del
,	val_pr_diff_fa_return
,	val_pr_diff_net_fa_return
,	val_pv_fa
,	val_net_pv_fa
,	val_claim_fa
,	val_claim_net_fa
,	currency_iso_cd
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
      agg.client_id
,	agg.store_id
,	agg.inv_id
,	agg.cy_month
,	agg.dat_valid_from
,	agg.dat_valid_until
,	itmp.item_sid_map                                                    AS item_id
,	agg.val_rtl_ejr                        / cry.rate_currency_exchange  AS val_rtl_ejr
,	agg.val_rtl_net_ejr                    / cry.rate_currency_exchange  AS val_rtl_net_ejr
,	agg.val_return_ejr                     / cry.rate_currency_exchange  AS val_return_ejr
,	agg.val_return_net_ejr                 / cry.rate_currency_exchange  AS val_return_net_ejr
,	agg.qty_piece_ejr
,	agg.qty_return_ejr
,	agg.diff_inv_stc_calc_cnt
,	agg.diff_inv_stc_calc_price_avg        / cry.rate_currency_exchange  AS diff_inv_stc_calc_price_avg
,	agg.diff_inv_stc_calc_prc_avg_net      / cry.rate_currency_exchange  AS diff_inv_stc_calc_prc_avg_net
,	agg.diff_inv_stc_calc_val              / cry.rate_currency_exchange  AS diff_inv_stc_calc_val
,	agg.diff_inv_stc_calc_val_net          / cry.rate_currency_exchange  AS diff_inv_stc_calc_val_net
,	agg.diff_inv_stc_calc_val_net_diff     / cry.rate_currency_exchange  AS diff_inv_stc_calc_val_net_diff
,	agg.val_abs                            / cry.rate_currency_exchange  AS val_abs
,	agg.val_net_abs                        / cry.rate_currency_exchange  AS val_net_abs
,	agg.val_pr_diff_del                    / cry.rate_currency_exchange  AS val_pr_diff_del
,	agg.val_pr_diff_net_del                / cry.rate_currency_exchange  AS val_pr_diff_net_del
,	agg.val_pr_diff_return                 / cry.rate_currency_exchange  AS val_pr_diff_return
,	agg.val_pr_diff_net_return             / cry.rate_currency_exchange  AS val_pr_diff_net_return
,	agg.val_pv                             / cry.rate_currency_exchange  AS val_pv
,	agg.val_net_pv                         / cry.rate_currency_exchange  AS val_net_pv
,	agg.val_claim                          / cry.rate_currency_exchange  AS val_claim
,	agg.val_claim_net                      / cry.rate_currency_exchange  AS val_claim_net
,	agg.val_rtl_fa_ejr                     / cry.rate_currency_exchange  AS val_rtl_fa_ejr
,	agg.val_rtl_net_fa_ejr                 / cry.rate_currency_exchange  AS val_rtl_net_fa_ejr
,	agg.val_return_fa_ejr                  / cry.rate_currency_exchange  AS val_return_fa_ejr
,	agg.val_return_net_fa_ejr              / cry.rate_currency_exchange  AS val_return_net_fa_ejr
,	agg.qty_piece_fa_ejr
,	agg.qty_return_fa_ejr
,	agg.diff_inv_stc_calc_cnt_fa
,	agg.diff_inv_stc_calc_val_fa           / cry.rate_currency_exchange  AS diff_inv_stc_calc_val_fa
,	agg.diff_inv_stc_calc_val_net_fa       / cry.rate_currency_exchange  AS diff_inv_stc_calc_val_net_fa
,	agg.val_abs_fa                         / cry.rate_currency_exchange  AS val_abs_fa
,	agg.val_net_abs_fa                     / cry.rate_currency_exchange  AS val_net_abs_fa
,	agg.val_pr_diff_fa_del                 / cry.rate_currency_exchange  AS val_pr_diff_fa_del
,	agg.val_pr_diff_net_fa_del             / cry.rate_currency_exchange  AS val_pr_diff_net_fa_del
,	agg.val_pr_diff_fa_return              / cry.rate_currency_exchange  AS val_pr_diff_fa_return
,	agg.val_pr_diff_net_fa_return          / cry.rate_currency_exchange  AS val_pr_diff_net_fa_return
,	agg.val_pv_fa                          / cry.rate_currency_exchange  AS val_pv_fa
,	agg.val_net_pv_fa                      / cry.rate_currency_exchange  AS val_net_pv_fa
,	agg.val_claim_fa                       / cry.rate_currency_exchange  AS val_claim_fa
,	agg.val_claim_net_fa                   / cry.rate_currency_exchange  AS val_claim_net_fa
,	cry.currency_iso_cd
FROM p_lew_bil_ac.v_agg_store_item_inv_all AS agg

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
	ON agg.client_id = cry.client_id
	AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN p_lew_core_ac.v_item_map_key AS itmp
	ON itmp.client_id = agg.client_id
	AND itmp.item_sid = agg.item_id
;