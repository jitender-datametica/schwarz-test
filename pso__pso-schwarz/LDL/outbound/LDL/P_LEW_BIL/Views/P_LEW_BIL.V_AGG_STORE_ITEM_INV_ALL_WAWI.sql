CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_store_item_inv_all_wawi AS SELECT client_id,
 st_loc_sid,
 inv_id,
 cy_month,
 dat_formdate,
 dat_valid_from,
 dat_valid_until,
 item_sid,
 val_rtl_ejr,
 val_rtl_net_ejr,
 val_return_ejr,
 val_return_net_ejr,
 qty_piece_ejr,
 qty_return_ejr,
 diff_inv_stc_calc_cnt,
 diff_inv_stc_calc_val,
 diff_inv_stc_calc_net_val,
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
  END AS val_claim_net_fa,
 foodaction_fg_asis,
 dwh_created
FROM ldl_p_lew_bil.t_agg_store_item_inv_all;