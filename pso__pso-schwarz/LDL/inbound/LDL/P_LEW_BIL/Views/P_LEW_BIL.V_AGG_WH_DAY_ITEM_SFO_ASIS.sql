CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_WH_DAY_ITEM_SFO_ASIS as

   SELECT
     agg.client_id,
   agg.loc_sid_wh,
   agg.aspect_id,
   agg.booking_dat,
   agg.sfotype_id,
   agg.item_sid,
   agg.pcwo_reason_id,
   agg.sfo_total_qty                                                             AS sfo_total_qty_asis,
   agg.sfo_wrtoff_zero_qty                                                       AS sfo_wrtoff_zero_qty_asis,
    agg.sfo_total_rtl_rl_val  / cry.exchange_rate                                 AS sfo_total_rtl_rl_val_asis,
    agg.sfo_total_rtl_rl_net_val  / cry.exchange_rate                             AS sfo_total_rtl_rl_net_val_asis,
    agg.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate                            AS sfo_wrtoff_zero_rtl_rl_val_asis,
    agg.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate                        AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
    agg.val_pr_diff_sfo / cry.exchange_rate                                       AS val_pr_diff_sfo_asis,
    agg.val_pr_diff_net_sfo / cry.exchange_rate                                   AS val_pr_diff_net_sfo_asis,
   agg.sfo_total_fa_qty                                                          AS sfo_total_fa_qty_asis,
   agg.sfo_wrtoff_zero_fa_qty                                                    AS sfo_wrtoff_zero_fa_qty_asis,
    agg.sfo_total_rtl_rl_fa_val  / cry.exchange_rate                              AS sfo_total_rtl_rl_fa_val_asis,
    agg.sfo_total_rtl_rl_net_fa_val  / cry.exchange_rate                          AS sfo_total_rtl_rl_net_fa_val_asis,
    agg.sfo_wrtoff_zero_rtl_rl_fa_val / cry.exchange_rate                         AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
    agg.sfo_wrtoff_zero_rtl_rl_net_fa_val / cry.exchange_rate                     AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
    agg.val_pr_diff_fa_sfo / cry.exchange_rate                                    AS val_pr_diff_fa_sfo_asis,
    agg.val_pr_diff_net_fa_sfo / cry.exchange_rate                                AS val_pr_diff_net_fa_sfo_asis,
   cry.curr_cd_from
  FROM p_lew_bil.v_agg_wh_day_item_sfo AS agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS cry
   ON  agg.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   ;