CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_wh_org_day_item_sfo_asis AS
SELECT AGG.client_id,
 WH.src_wh_id AS wh_id,
 AGG.aspect_id,
 AGG.booking_dat AS dat_formdate,
 ITMP.item_sid_map AS item_id,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty_asis AS qty_total_sfo_asis,
  CASE
  WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104,
       123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138,
       139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157) OR AGG.sfotype_id IN (137, 147)
     AND AGG.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8,
       136, 137, 152, 155) OR AGG.sfotype_id IN (181, 191) AND AGG.pcwo_reason_id IN (82, 83, 84)
  THEN AGG.sfo_total_qty_asis
  ELSE NULL
  END AS qty_total_wtof_sfo_asis,
 AGG.sfo_wrtoff_zero_qty_asis AS qty_total_sfo_wrtoff_zero_asis,
 AGG.sfo_total_rtl_rl_val_asis AS val_rtl_rcptline_sfo_asis,
 AGG.sfo_total_rtl_rl_net_val_asis AS val_rtl_rl_net_sfo_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_val_asis AS val_wrtoff_zero_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_net_val_asis AS val_wrtoff_zero_net_asis,
 AGG.val_pr_diff_sfo_asis,
 AGG.val_pr_diff_net_sfo_asis,
 AGG.sfo_total_fa_qty_asis AS qty_total_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_fa_qty_asis AS qty_tot_sfo_wrtoff_zr_fa_asis,
 AGG.sfo_total_rtl_rl_fa_val_asis AS val_rtl_rcptline_fa_sfo_asis,
 AGG.sfo_total_rtl_rl_net_fa_val_asis AS val_rtl_rl_net_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_fa_val_asis AS val_wrtoff_zero_fa_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis AS val_wrtoff_zero_net_fa_asis,
 AGG.val_pr_diff_fa_sfo_asis,
 AGG.val_pr_diff_net_fa_sfo_asis,
 AGG.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_wh_org_day_item_sfo_asis AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON AGG.client_id = WH.client_id AND AGG.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid = ITMP.item_sid;