CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STR_DAY_CAL_ITM_SFO_ASIS_1 as

   SELECT
    agg.client_id,
   agg.loc_sid_store,
   agg.src_orig_store_nr,
   agg.booking_dat,
   agg.cy_week,
   agg.cy_month,
   agg.item_sid,
   agg.sfotype_id,
   agg.pcwo_reason_id,
   agg.sfo_total_qty                                                                                                                     AS sfo_total_qty_asis,
   agg.sfo_wrtoff_zero_qty                                                                                                               AS sfo_wrtoff_zero_qty_asis,
   agg.sfo_total_rtl_rl_val  / cry.exchange_rate                                                                                         AS sfo_total_rtl_rl_val_asis,
   agg.sfo_total_rtl_rl_net_val  / cry.exchange_rate                                                                                     AS sfo_total_rtl_rl_net_val_asis,
   agg.sfo_wrtoff_zero_rtl_rl_val / cry.exchange_rate                                                                                    AS sfo_wrtoff_zero_rtl_rl_val_asis,
   agg.sfo_wrtoff_zero_rtl_rl_net_val / cry.exchange_rate                                                                                AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
   (ABS(CAST(agg.sfo_total_wh_val  AS NUMBER(38,5))      / CASE WHEN agg.sfo_total_qty = 0 THEN null ELSE agg.sfo_total_qty END)) / cry.exchange_rate                                  AS price_wh_sfo_asis,
   (ABS(CAST(agg.sfo_total_wh_net_val  AS NUMBER(38,5))      / CASE WHEN agg.sfo_total_qty = 0 THEN null ELSE agg.sfo_total_qty END)) / cry.exchange_rate                              AS price_wh_net_sfo_asis,
   (ABS(CAST(agg.sfo_total_store_val AS NUMBER(38,5))      / CASE WHEN agg.sfo_total_qty = 0 THEN null ELSE agg.sfo_total_qty END)) / cry.exchange_rate                                AS price_str_sfo_asis,
   (ABS(CAST(agg.sfo_total_store_net_val AS NUMBER(38,5))      / CASE WHEN agg.sfo_total_qty = 0 THEN null ELSE agg.sfo_total_qty END)) / cry.exchange_rate                            AS price_str_net_sfo_asis,
   agg.val_pr_diff_sfo / cry.exchange_rate                                                                                               AS val_pr_diff_sfo_asis,
   agg.val_pr_diff_net_sfo / cry.exchange_rate                                                                                           AS val_pr_diff_net_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_total_qty_asis                   ELSE NULL END                                             AS sfo_total_fa_qty_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_wrtoff_zero_qty_asis             ELSE NULL END                                             AS sfo_wrtoff_zero_fa_qty_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_total_rtl_rl_val_asis            ELSE NULL END                                             AS sfo_total_rtl_rl_fa_val_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_total_rtl_rl_net_val_asis        ELSE NULL END                                             AS sfo_total_rtl_rl_net_fa_val_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_wrtoff_zero_rtl_rl_val_asis      ELSE NULL END                                             AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN sfo_wrtoff_zero_rtl_rl_net_val_asis  ELSE NULL END                                             AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN price_wh_sfo_asis                    ELSE NULL END                                             AS price_wh_fa_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN price_wh_net_sfo_asis                ELSE NULL END                                             AS price_wh_net_fa_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN price_str_sfo_asis                   ELSE NULL END                                             AS price_str_fa_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN price_str_net_sfo_asis               ELSE NULL END                                             AS price_str_net_fa_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN val_pr_diff_sfo_asis                 ELSE NULL END                                             AS val_pr_diff_fa_sfo_asis,
   CASE WHEN agg.foodaction_fg = 1   THEN val_pr_diff_net_sfo_asis             ELSE NULL END                                             AS val_pr_diff_net_fa_sfo_asis,
   cry.curr_cd_from,
   agg.src_fg

   FROM p_lew_bil.t_agg_store_day_item_sfo_1 AS agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON  agg.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE';