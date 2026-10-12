CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_WH_ORG_DAY_SIG_SFO_ASIS_2 as
   SELECT
      sfo.client_id,
   sfo.loc_sid_wh,
   sfo.aspect_id,
   sfo.booking_dat,
   sfo.cy_month,
   CAST(suig.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id,
   sfo.sfotype_id,
   sfo.sfo_total_qty                                       AS sfo_total_qty_asis,
   sfo.sfo_wrtoff_zero_qty                                 AS sfo_wrtoff_zero_qty_asis,
   sfo.sfo_total_rtl_rl_val / cry.exchange_rate            AS sfo_total_rtl_rl_val_asis,
   sfo.sfo_total_rtl_rl_net_val / cry.exchange_rate        AS sfo_total_rtl_rl_net_val_asis,
   sfo.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate      AS sfo_wrtoff_zero_rtl_rl_val_asis,
   sfo.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate  AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
   sfo.val_pr_diff_sfo / cry.exchange_rate                 AS val_pr_diff_sfo_asis,
   sfo.val_pr_diff_net_sfo / cry.exchange_rate             AS val_pr_diff_net_sfo_asis,
   sfo.sfo_total_qty                                       AS sfo_total_fa_qty_asis,
   sfo.sfo_wrtoff_zero_qty                                 AS sfo_wrtoff_zero_fa_qty_asis,
   sfo.sfo_total_rtl_rl_val / cry.exchange_rate            AS sfo_total_rtl_rl_fa_val_asis,
   sfo.sfo_total_rtl_rl_net_val / cry.exchange_rate        AS sfo_total_rtl_rl_net_fa_val_asis,
   sfo.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate      AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
   sfo.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate  AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
   sfo.val_pr_diff_sfo / cry.exchange_rate                 AS val_pr_diff_fa_sfo_asis,
   sfo.val_pr_diff_net_sfo / cry.exchange_rate             AS val_pr_diff_net_fa_sfo_asis,
   cry.curr_cd_from
   FROM p_lew_bil.v_agg_wh_org_day_sig_sfo_2 sfo
   INNER JOIN p_lew_core_ac.v_subitemgroup_2 suig
   ON sfo.client_id = suig.client_id
   AND sfo.sub_item_grp_sid = suig.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON sfo.client_id = cry.client_id
   AND Current_Date BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND Current_Date BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   ;