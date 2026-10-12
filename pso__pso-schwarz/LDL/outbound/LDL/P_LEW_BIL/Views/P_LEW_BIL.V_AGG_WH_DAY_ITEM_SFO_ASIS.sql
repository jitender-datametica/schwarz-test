CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_wh_day_item_sfo_asis AS SELECT AGG.client_id,
 AGG.loc_sid_wh,
 AGG.aspect_id,
 AGG.booking_dat,
 AGG.sfotype_id,
 AGG.item_sid,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty AS sfo_total_qty_asis,
 AGG.sfo_wrtoff_zero_qty AS sfo_wrtoff_zero_qty_asis,
  AGG.sfo_total_rtl_rl_val / CRY.exchange_rate AS sfo_total_rtl_rl_val_asis,
  AGG.sfo_total_rtl_rl_net_val / CRY.exchange_rate AS sfo_total_rtl_rl_net_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
  AGG.val_pr_diff_sfo / CRY.exchange_rate AS val_pr_diff_sfo_asis,
  AGG.val_pr_diff_net_sfo / CRY.exchange_rate AS val_pr_diff_net_sfo_asis,
 AGG.sfo_total_fa_qty AS sfo_total_fa_qty_asis,
 AGG.sfo_wrtoff_zero_fa_qty AS sfo_wrtoff_zero_fa_qty_asis,
  AGG.sfo_total_rtl_rl_fa_val / CRY.exchange_rate AS sfo_total_rtl_rl_fa_val_asis,
  AGG.sfo_total_rtl_rl_net_fa_val / CRY.exchange_rate AS sfo_total_rtl_rl_net_fa_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_fa_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_fa_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
  AGG.val_pr_diff_fa_sfo / CRY.exchange_rate AS val_pr_diff_fa_sfo_asis,
  AGG.val_pr_diff_net_fa_sfo / CRY.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from
FROM ldl_p_lew_bil.v_agg_wh_day_item_sfo AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';