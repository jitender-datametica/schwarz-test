CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_agg_store_day_sfo_2
AS
SELECT AGG.client_id,
 AGG.loc_sid_store AS store_id,
 AGG.src_orig_store_nr AS orig_store_nr,
 AGG.booking_dat AS dat_formdate,
 AGG.cy_month,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty_asis AS qty_total_sfo_asis,
 AGG.sfo_wrtoff_zero_qty_asis AS qty_total_sfo_wrtoff_zero_asis,
  AGG.sfo_total_rtl_rl_val_asis / CRY.exchange_rate AS val_rtl_rl_sfo_asis,
  AGG.sfo_total_rtl_rl_net_val_asis / CRY.exchange_rate AS val_rtl_rl_net_sfo_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_val_asis / CRY.exchange_rate AS val_wrtoff_zero_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_val_asis / CRY.exchange_rate AS val_wrtoff_zero_net_asis,
  AGG.val_pr_diff_sfo_asis / CRY.exchange_rate AS val_pr_diff_sfo_asis,
  AGG.val_pr_diff_net_sfo_asis / CRY.exchange_rate AS val_pr_diff_net_sfo_asis,
 AGG.sfo_total_fa_qty_asis AS qty_total_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_fa_qty_asis AS qty_tot_sfo_wrtoff_zr_fa_asis,
  AGG.sfo_total_rtl_rl_fa_val_asis / CRY.exchange_rate AS val_rtl_rl_fa_sfo_asis,
  AGG.sfo_total_rtl_rl_net_fa_val_asis / CRY.exchange_rate AS val_rtl_rl_net_fa_sfo_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_fa_val_asis / CRY.exchange_rate AS val_wrtoff_zero_fa_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis / CRY.exchange_rate AS val_wrtoff_zero_net_fa_asis,
  AGG.val_pr_diff_fa_sfo_asis / CRY.exchange_rate AS val_pr_diff_fa_sfo_asis,
  AGG.val_pr_diff_net_fa_sfo_asis / CRY.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from AS currency_iso_cd_asis
FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';

