CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_str_day_cal_itm_sfo_asis_1 AS SELECT AGG.client_id,
 AGG.loc_sid_store,
 AGG.src_orig_store_nr,
 AGG.booking_dat,
 AGG.cy_week,
 AGG.cy_month,
 AGG.item_sid,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty AS sfo_total_qty_asis,
 AGG.sfo_wrtoff_zero_qty AS sfo_wrtoff_zero_qty_asis,
  AGG.sfo_total_rtl_rl_val / CRY.exchange_rate AS sfo_total_rtl_rl_val_asis,
  AGG.sfo_total_rtl_rl_net_val / CRY.exchange_rate AS sfo_total_rtl_rl_net_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_val_asis,
  AGG.sfo_wrtoff_zero_rtl_rl_net_val / CRY.exchange_rate AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
  ABS(CAST(AGG.sfo_total_wh_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END) / CRY.exchange_rate AS price_wh_sfo_asis,
  ABS(CAST(AGG.sfo_total_wh_net_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END) / CRY.exchange_rate AS price_wh_net_sfo_asis,
  ABS(CAST(AGG.sfo_total_store_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END) / CRY.exchange_rate AS price_str_sfo_asis,
  ABS(CAST(AGG.sfo_total_store_net_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END) / CRY.exchange_rate AS price_str_net_sfo_asis,
  AGG.val_pr_diff_sfo / CRY.exchange_rate AS val_pr_diff_sfo_asis,
  AGG.val_pr_diff_net_sfo / CRY.exchange_rate AS val_pr_diff_net_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_total_qty
  ELSE NULL
  END AS sfo_total_fa_qty_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_wrtoff_zero_qty
  ELSE NULL
  END AS sfo_wrtoff_zero_fa_qty_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_total_rtl_rl_val / CRY.exchange_rate
  ELSE NULL
  END AS sfo_total_rtl_rl_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_total_rtl_rl_net_val / CRY.exchange_rate
  ELSE NULL
  END AS sfo_total_rtl_rl_net_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_wrtoff_zero_rtl_rl_val / CRY.exchange_rate
  ELSE NULL
  END AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.sfo_wrtoff_zero_rtl_rl_net_val / CRY.exchange_rate
  ELSE NULL
  END AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN ABS(CAST(AGG.sfo_total_wh_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END) / CRY.exchange_rate
  ELSE NULL
  END AS price_wh_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN ABS(CAST(AGG.sfo_total_wh_net_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END) / CRY.exchange_rate
  ELSE NULL
  END AS price_wh_net_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN ABS(CAST(AGG.sfo_total_store_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END) / CRY.exchange_rate
  ELSE NULL
  END AS price_str_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN ABS(CAST(AGG.sfo_total_store_net_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END) / CRY.exchange_rate
  ELSE NULL
  END AS price_str_net_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.val_pr_diff_sfo / CRY.exchange_rate
  ELSE NULL
  END AS val_pr_diff_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg = 1
  THEN AGG.val_pr_diff_net_sfo / CRY.exchange_rate
  ELSE NULL
  END AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from,
 AGG.src_fg
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';