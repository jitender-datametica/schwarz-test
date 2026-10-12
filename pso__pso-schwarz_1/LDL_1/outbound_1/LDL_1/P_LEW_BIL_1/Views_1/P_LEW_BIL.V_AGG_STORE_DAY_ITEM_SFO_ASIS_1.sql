CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_store_day_item_sfo_asis_1 AS SELECT AGG.client_id,
 AGG.loc_sid_store,
 AGG.src_orig_store_nr,
 AGG.booking_dat,
 AGG.cy_month,
 AGG.item_sid,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty AS sfo_total_qty_asis,
 AGG.sfo_wrtoff_zero_qty AS sfo_wrtoff_zero_qty_asis,
 AGG.sfo_total_rtl_rl_val AS sfo_total_rtl_rl_val_asis,
 AGG.sfo_total_rtl_rl_net_val AS sfo_total_rtl_rl_net_val_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_val AS sfo_wrtoff_zero_rtl_rl_val_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_net_val AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE ABS(CAST(AGG.sfo_total_wh_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END)
  END AS price_wh_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE ABS(CAST(AGG.sfo_total_wh_net_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END)
  END AS price_wh_net_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE ABS(CAST(AGG.sfo_total_store_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END)
  END AS price_str_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE ABS(CAST(AGG.sfo_total_store_net_val AS BIGNUMERIC) / CASE
     WHEN AGG.sfo_total_qty = 0
     THEN NULL
     ELSE AGG.sfo_total_qty
     END)
  END AS price_str_net_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE AGG.val_pr_diff_sfo
  END AS val_pr_diff_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
  THEN NULL
  ELSE AGG.val_pr_diff_net_sfo
  END AS val_pr_diff_net_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_total_qty
  ELSE NULL
  END AS sfo_total_fa_qty_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_wrtoff_zero_qty
  ELSE NULL
  END AS sfo_wrtoff_zero_fa_qty_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_total_rtl_rl_val
  ELSE NULL
  END AS sfo_total_rtl_rl_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_total_rtl_rl_net_val
  ELSE NULL
  END AS sfo_total_rtl_rl_net_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_wrtoff_zero_rtl_rl_val
  ELSE NULL
  END AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sfo_wrtoff_zero_rtl_rl_net_val
  ELSE NULL
  END AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE ABS(CAST(AGG.sfo_total_wh_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END)
   END
  ELSE NULL
  END AS price_wh_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE ABS(CAST(AGG.sfo_total_wh_net_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END)
   END
  ELSE NULL
  END AS price_wh_net_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE ABS(CAST(AGG.sfo_total_store_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END)
   END
  ELSE NULL
  END AS price_str_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE ABS(CAST(AGG.sfo_total_store_net_val AS BIGNUMERIC) / CASE
      WHEN AGG.sfo_total_qty = 0
      THEN NULL
      ELSE AGG.sfo_total_qty
      END)
   END
  ELSE NULL
  END AS price_str_net_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE AGG.val_pr_diff_sfo
   END
  ELSE NULL
  END AS val_pr_diff_fa_sfo_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.sfotype_id IN (131, 141) AND AGG.src_fg = 1
   THEN NULL
   ELSE AGG.val_pr_diff_net_sfo
   END
  ELSE NULL
  END AS val_pr_diff_net_fa_sfo_asis,
 C.curr_cd,
 C.curr_sid,
 AGG.src_fg
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON AGG.client_id = C.client_id;