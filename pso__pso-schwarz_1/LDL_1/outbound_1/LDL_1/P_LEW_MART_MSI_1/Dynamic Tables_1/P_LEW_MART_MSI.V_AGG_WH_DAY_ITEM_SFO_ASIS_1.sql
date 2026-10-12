CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_wh_day_item_sfo_asis_1 AS
SELECT AGG.client_id,
 WH.src_wh_id AS wh_id,
 AGG.booking_dat AS dat_formdate,
 ITMP.item_sid_map AS item_id,
 AGG.sfotype_id,
 AGG.pcwo_reason_id,
 AGG.sfo_total_qty_asis AS qty_total_sfo_asis,
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
FROM ldl_p_lew_bil_ac.v_agg_wh_day_item_sfo_asis_1 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON AGG.client_id = WH.client_id AND AGG.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid = ITMP.item_sid;

