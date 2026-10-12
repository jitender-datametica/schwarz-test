CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_store_item_inv_all (client_id, store_id, inv_id, cy_month, dat_valid_from,
dat_valid_until, item_id, val_rtl_ejr, val_rtl_net_ejr, val_return_ejr, val_return_net_ejr, qty_piece_ejr,
qty_return_ejr, diff_inv_stc_calc_cnt, diff_inv_stc_calc_price_avg, diff_inv_stc_calc_prc_avg_net, diff_inv_stc_calc_val
, diff_inv_stc_calc_val_net, diff_inv_stc_calc_val_net_diff, val_abs, val_net_abs, val_pr_diff_del, val_pr_diff_net_del
, val_pr_diff_return, val_pr_diff_net_return, val_pv, val_net_pv, val_claim, val_claim_net, val_rtl_fa_ejr,
val_rtl_net_fa_ejr, val_return_fa_ejr, val_return_net_fa_ejr, qty_piece_fa_ejr, qty_return_fa_ejr,
diff_inv_stc_calc_cnt_fa, diff_inv_stc_calc_val_fa, diff_inv_stc_calc_val_net_fa, val_abs_fa, val_net_abs_fa,
val_pr_diff_fa_del, val_pr_diff_net_fa_del, val_pr_diff_fa_return, val_pr_diff_net_fa_return, val_pv_fa, val_net_pv_fa,
val_claim_fa, val_claim_net_fa) AS SELECT client_id,
 st_loc_sid AS store_id,
 inv_id,
 cy_month,
 dat_valid_from,
 dat_valid_until,
 item_sid AS item_id,
 val_rtl_ejr,
 val_rtl_net_ejr,
 val_return_ejr,
 val_return_net_ejr,
 qty_piece_ejr,
 qty_return_ejr,
 diff_inv_stc_calc_cnt,
  diff_inv_stc_calc_val / CASE
   WHEN diff_inv_stc_calc_cnt <> 0
   THEN diff_inv_stc_calc_cnt
   ELSE NULL
   END AS diff_inv_stc_calc_price_avg,
  diff_inv_stc_calc_net_val / CASE
   WHEN diff_inv_stc_calc_cnt <> 0
   THEN diff_inv_stc_calc_cnt
   ELSE NULL
   END AS diff_inv_stc_calc_prc_avg_net,
 diff_inv_stc_calc_val,
 diff_inv_stc_calc_net_val AS diff_inv_stc_calc_val_net,
 diff_inv_stc_calc_net_val_diff AS diff_inv_stc_calc_val_net_diff,
 val_abs,
 val_net_abs,
 val_pr_diff_del,
 val_pr_diff_net_del,
 val_pr_diff_return,
 val_pr_diff_net_return,
 val_pv,
 val_net_pv,
 val_claim,
 val_claim_net,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_rtl_ejr
  ELSE NULL
  END AS val_rtl_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_rtl_net_ejr
  ELSE NULL
  END AS val_rtl_net_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_return_ejr
  ELSE NULL
  END AS val_return_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_return_net_ejr
  ELSE NULL
  END AS val_return_net_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN qty_piece_ejr
  ELSE NULL
  END AS qty_piece_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN qty_return_ejr
  ELSE NULL
  END AS qty_return_fa_ejr,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN diff_inv_stc_calc_cnt
  ELSE NULL
  END AS diff_inv_stc_calc_cnt_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN diff_inv_stc_calc_val
  ELSE NULL
  END AS diff_inv_stc_calc_val_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN diff_inv_stc_calc_net_val
  ELSE NULL
  END AS diff_inv_stc_calc_net_val_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_abs
  ELSE NULL
  END AS val_abs_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_net_abs
  ELSE NULL
  END AS val_net_abs_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_pr_diff_del
  ELSE NULL
  END AS val_pr_diff_fa_del,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_pr_diff_net_del
  ELSE NULL
  END AS val_pr_diff_net_fa_del,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_pr_diff_return
  ELSE NULL
  END AS val_pr_diff_fa_return,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_pr_diff_net_return
  ELSE NULL
  END AS val_pr_diff_net_fa_return,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_pv
  ELSE NULL
  END AS val_pv_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_net_pv
  ELSE NULL
  END AS val_net_pv_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_claim
  ELSE NULL
  END AS val_claim_fa,
  CASE
  WHEN foodaction_fg_asis = 1
  THEN val_claim_net
  ELSE NULL
  END AS val_claim_net_fa
FROM ldl_p_lew_bil.t_agg_store_item_inv_all AS AGG
UNION ALL
SELECT client_id,
 loc_sid_store AS store_id,
 1 AS inv_id,
 cy_month,
 dwh_cal_dt AS dat_valid_from,
 dwh_cal_dt AS dat_valid_until,
 item_sid AS item_id,
 COALESCE(retail_val, 0) AS val_rtl_ejr,
 COALESCE(retail_net_val, 0) AS val_rtl_net_ejr,
 0 AS val_return_ejr,
 0 AS val_return_net_ejr,
 qty_act AS qty_piece_ejr,
 0 AS qty_return_ejr,
  COALESCE(diff_inv_stc_calc_cnt, 0) + COALESCE(diff_inv_return_qty, 0) AS diff_inv_stc_calc_cnt,
 CAST(NULL AS NUMERIC) AS diff_inv_stc_calc_price_avg,
 CAST(NULL AS NUMERIC) AS diff_inv_stc_calc_prc_avg_net,
  COALESCE(diff_inv_stc_calc_val, 0) + COALESCE(diff_inv_return_val, 0) AS diff_inv_stc_calc_val,
  COALESCE(diff_inv_stc_calc_net_val, 0) + COALESCE(diff_inv_return_net_val, 0) AS diff_inv_stc_calc_val_net,
 CAST(NULL AS NUMERIC) AS diff_inv_stc_calc_net_val_diff,
 abs_val AS val_abs,
 net_abs_val AS val_net_abs,
 pr_diff_del_val AS val_pr_diff_del,
 pr_diff_net_del_val AS val_pr_diff_net_del,
 pr_diff_return_val AS val_pr_diff_return,
 pr_diff_net_return_val AS val_pr_diff_net_return,
 pv_val AS val_pv,
 net_pv_val AS val_net_pv,
 claim_val AS val_claim,
 claim_net_val AS val_claim_net,
 retail_fa_val AS val_rtl_fa_ejr,
 retail_net_fa_val AS val_rtl_net_fa_ejr,
 return_fa_val AS val_return_fa_ejr,
 return_net_fa_val AS val_return_net_fa_ejr,
 qty_piece_fa AS qty_piece_fa_ejr,
 qty_return_fa AS qty_return_fa_ejr,
 diff_inv_stc_calc_cnt_fa,
 diff_inv_stc_calc_val_fa,
 diff_inv_stc_calc_net_val_fa AS diff_inv_stc_calc_val_net_fa,
 abs_fa_val AS val_abs_fa,
 net_abs_fa_val AS val_net_abs_fa,
 pr_diff_fa_del_val AS val_pr_diff_fa_del,
 pr_diff_net_fa_del_val AS val_pr_diff_net_fa_del,
 pr_diff_fa_return_val AS val_pr_diff_fa_return,
 pr_diff_net_fa_return_val AS val_pr_diff_net_fa_return,
 pv_fa_val AS val_pv_fa,
 net_pv_fa_val AS val_net_pv_fa,
 claim_fa_val AS val_claim_fa,
 claim_net_fa_val AS val_claim_net_fa
FROM ldl_p_lew_bil.t_agg_item_store_day AS AGG;