CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_wh_org_day_sig_sfo_asis AS SELECT SFO.client_id,
 SFO.loc_sid_wh,
 SFO.aspect_id,
 SFO.booking_dat,
 SFO.cy_month,
 ROUND(CAST(SUIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 SFO.sfotype_id,
 SFO.sfo_total_qty AS sfo_total_qty_asis,
 SFO.sfo_wrtoff_zero_qty AS sfo_wrtoff_zero_qty_asis,
  SFO.sfo_total_rtl_rl_val / CRY.exchange_rate AS sfo_total_rtl_rl_val_asis,
  SFO.sfo_total_rtl_rl_net_val / CRY.exchange_rate AS sfo_total_rtl_rl_net_val_asis,
  SFO.sfo_wrtoff_zero_rtl_rl_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_val_asis,
  SFO.sfo_wrtoff_zero_rtl_rl_net_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
  SFO.val_pr_diff_sfo / CRY.exchange_rate AS val_pr_diff_sfo_asis,
  SFO.val_pr_diff_net_sfo / CRY.exchange_rate AS val_pr_diff_net_sfo_asis,
 SFO.sfo_total_qty AS sfo_total_fa_qty_asis,
 SFO.sfo_wrtoff_zero_qty AS sfo_wrtoff_zero_fa_qty_asis,
  SFO.sfo_total_rtl_rl_val / CRY.exchange_rate AS sfo_total_rtl_rl_fa_val_asis,
  SFO.sfo_total_rtl_rl_net_val / CRY.exchange_rate AS sfo_total_rtl_rl_net_fa_val_asis,
  SFO.sfo_wrtoff_zero_rtl_rl_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
  SFO.sfo_wrtoff_zero_rtl_rl_net_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
  SFO.val_pr_diff_sfo / CRY.exchange_rate AS val_pr_diff_fa_sfo_asis,
  SFO.val_pr_diff_net_sfo / CRY.exchange_rate AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from
FROM ldl_p_lew_bil.v_agg_wh_org_day_sig_sfo AS SFO
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SUIG ON SFO.client_id = SUIG.client_id AND SFO.sub_item_grp_sid = SUIG.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON SFO.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';