/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_SIG_SFO_ASIS
#----------------------------------------------------------------------------
# History:
#  1.1  27.06.2025    Marcin Malec              AP0280474, user story 752224, adding column QTY_TOTAL_WTOF_SFO_ASIS, with writeoff filter, used in stk/kg metrics
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_SIG_SFO_ASIS
(
client_id
, store_id
, orig_store_nr
, dat_formdate
, subitemgroup_id
, sfotype_id
, pcwo_reason_id
, qty_total_sfo_asis
, qty_total_wtof_sfo_asis
, qty_total_sfo_wrtoff_zero_asis
, val_rtl_rcptline_sfo_asis
, val_rtl_rl_net_sfo_asis
, val_wrtoff_zero_asis
, val_wrtoff_zero_net_asis
, val_pr_diff_sfo_asis
, val_pr_diff_net_sfo_asis
, qty_total_fa_sfo_asis
, qty_tot_sfo_wrtoff_zr_fa_asis
, val_rtl_rcptline_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis
, val_wrtoff_zero_fa_asis
, val_wrtoff_zero_net_fa_asis
, val_pr_diff_fa_sfo_asis
, val_pr_diff_net_fa_sfo_asis
, currency_iso_cd
 )
AS
   SELECT
     client_id
   , store_id
   , orig_store_nr
   , dat_formdate
   , subitemgroup_id
   , sfotype_id
   , pcwo_reason_id
   , qty_total_sfo_asis
   , qty_total_wtof_sfo_asis
   , qty_total_sfo_wrtoff_zero_asis
   , val_rtl_rcptline_sfo_asis
   , val_rtl_rl_net_sfo_asis
   , val_wrtoff_zero_asis
   , val_wrtoff_zero_net_asis
   , val_pr_diff_sfo_asis
   , val_pr_diff_net_sfo_asis
   , qty_total_fa_sfo_asis
   , qty_tot_sfo_wrtoff_zr_fa_asis
   , val_rtl_rcptline_fa_sfo_asis
   , val_rtl_rl_net_fa_sfo_asis
   , val_wrtoff_zero_fa_asis
   , val_wrtoff_zero_net_fa_asis
   , val_pr_diff_fa_sfo_asis
   , val_pr_diff_net_fa_sfo_asis
   , currency_iso_cd
   FROM p_lew_mart_msi.v_agg_store_day_sig_sfo_asis;