/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_WH_ORG_DAY_ITEM_SFO_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.1  27.06.2025    Marcin Malec              AP0280474, user story 752224, adding column QTY_TOTAL_WTOF_SFO_ASIS, with writeoff filter, used in stk/kg metrics
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_wh_org_day_item_sfo_asis_2 (client_id, wh_id, aspect_id, dat_formdate
, item_id, sfotype_id, pcwo_reason_id, qty_total_sfo_asis, qty_total_wtof_sfo_asis, qty_total_sfo_wrtoff_zero_asis,
val_rtl_rcptline_sfo_asis, val_rtl_rl_net_sfo_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, val_pr_diff_sfo_asis
, val_pr_diff_net_sfo_asis, qty_total_fa_sfo_asis, qty_tot_sfo_wrtoff_zr_fa_asis, val_rtl_rcptline_fa_sfo_asis,
val_rtl_rl_net_fa_sfo_asis, val_wrtoff_zero_fa_asis, val_wrtoff_zero_net_fa_asis, val_pr_diff_fa_sfo_asis,
val_pr_diff_net_fa_sfo_asis, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_wh_org_day_item_sfo_asis_2;