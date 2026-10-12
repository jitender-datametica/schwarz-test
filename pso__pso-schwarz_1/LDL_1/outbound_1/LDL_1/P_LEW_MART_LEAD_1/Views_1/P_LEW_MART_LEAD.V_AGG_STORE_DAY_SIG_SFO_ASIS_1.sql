CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_sig_sfo_asis_1 (client_id, store_id, orig_store_nr,
dat_formdate, subitemgroup_id, sfotype_id, pcwo_reason_id, qty_total_sfo_asis, qty_total_wtof_sfo_asis,
qty_total_sfo_wrtoff_zero_asis, val_rtl_rcptline_sfo_asis, val_rtl_rl_net_sfo_asis, val_wrtoff_zero_asis,
val_wrtoff_zero_net_asis, val_pr_diff_sfo_asis, val_pr_diff_net_sfo_asis, qty_total_fa_sfo_asis,
qty_tot_sfo_wrtoff_zr_fa_asis, val_rtl_rcptline_fa_sfo_asis, val_rtl_rl_net_fa_sfo_asis, val_wrtoff_zero_fa_asis,
val_wrtoff_zero_net_fa_asis, val_pr_diff_fa_sfo_asis, val_pr_diff_net_fa_sfo_asis, currency_iso_cd) AS SELECT AGG.client_id
 ,
 AGG.loc_sid_store AS store_id,
 AGG.src_orig_store_nr AS orig_store_nr,
 AGG.booking_dat AS dat_formdate,
 AGG.subitemgroup_id,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty AS qty_total_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104,
       123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138,
       139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157) OR AGG.sfotype_id IN (137, 147)
     AND AGG.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8,
       136, 137, 152, 155) OR AGG.sfotype_id IN (181, 191) AND AGG.pcwo_reason_id IN (82, 83, 84)
  THEN AGG.sfo_total_qty
  ELSE NULL
  END AS qty_total_wtof_sfo_asis,
 AGG.sfo_wrtoff_zero_qty AS qty_total_sfo_wrtoff_zero_asis,
  AGG.sfo_total_rtl_rl_val / cry.exchange_rate AS val_rtl_rcptline_sfo_asis,
  AGG.sfo_total_rtl_rl_net_val / cry.exchange_rate AS val_rtl_rl_net_sfo_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate AS val_wrtoff_zero_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate AS val_wrtoff_zero_net_asis,
  AGG.val_pr_diff_sfo / cry.exchange_rate AS val_pr_diff_sfo_asis,
  AGG.val_pr_diff_net_sfo / cry.exchange_rate AS val_pr_diff_net_sfo_asis,
 AGG.sfo_total_fa_qty AS qty_total_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_fa_qty AS qty_tot_sfo_wrtoff_zr_fa_asis,
  AGG.sfo_total_rtl_rl_fa_val / cry.exchange_rate AS val_rtl_rcptline_fa_sfo_asis,
  AGG.sfo_total_rtl_rl_net_fa_val / cry.exchange_rate AS val_rtl_rl_net_fa_sfo_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_fa_val / cry.exchange_rate AS val_wrtoff_zero_fa_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_fa_val / cry.exchange_rate AS val_wrtoff_zero_net_fa_asis,
  AGG.val_pr_diff_fa_sfo / cry.exchange_rate AS val_pr_diff_fa_sfo_asis,
  AGG.val_pr_diff_net_fa_sfo / cry.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 cry.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_store_day_sig_sfo_asis_1 AS AGG
 INNER JOIN (SELECT XR_KN_H.client_id,
   XRTYP.src_kurst,
   XR_KN_H.curr_cd_from,
   XR_KN_H.curr_cd_to,
   XR_KN_H.curr_sid_from,
   XR_KN_H.curr_sid_to,
   XR_KN_H.exchange_rate,
   XR_KN_H.active_from_dt,
   XR_KN_H.active_to_dt,
   XR_KN_H.deleted_fg
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS XR_KN_H
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS XRTYP ON XR_KN_H.client_id = XRTYP.client_id AND XR_KN_H.x_rate_type_sid
      = XRTYP.x_rate_type_sid
  WHERE CURRENT_DATE BETWEEN XR_KN_H.dwh_valid_from AND XR_KN_H.dwh_valid_to
   AND XRTYP.src_kurst = '@BEWE') AS cry ON AGG.client_id = cry.client_id AND CURRENT_DATE BETWEEN cry.active_from_dt
   AND cry.active_to_dt;