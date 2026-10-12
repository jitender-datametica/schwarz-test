
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_agg_wh_day_sig_sfo_asis_2
AS
SELECT AGG.client_id,
 WH.src_wh_id AS wh_id,
 AGG.aspect_id,
 AGG.booking_dat AS dat_formdate,
 AGG.cy_month,
 AGG.subitemgroup_id,
 AGG.sfotype_id,
 AGG.sfo_total_qty_asis AS qty_total_sfo_asis,
 AGG.sfo_wrtoff_zero_qty_asis AS qty_total_sfo_wrtoff_zero_asis,
 AGG.sfo_total_rtl_rl_val_asis AS val_rtl_rl_sfo_asis,
 AGG.sfo_total_rtl_rl_net_val_asis AS val_rtl_rl_net_sfo_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_val_asis AS val_wrtoff_zero_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_net_val_asis AS val_wrtoff_zero_net_asis,
 AGG.val_pr_diff_sfo_asis,
 AGG.val_pr_diff_net_sfo_asis,
 AGG.sfo_total_fa_qty_asis AS qty_total_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_fa_qty_asis AS qty_tot_sfo_wrtoff_zr_fa_asis,
 AGG.sfo_total_rtl_rl_fa_val_asis AS val_rtl_rl_fa_sfo_asis,
 AGG.sfo_total_rtl_rl_net_fa_val_asis AS val_rtl_rl_net_fa_sfo_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_fa_val_asis AS val_wrtoff_zero_fa_asis,
 AGG.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis AS val_wrtoff_zero_net_fa_asis,
 AGG.val_pr_diff_fa_sfo_asis,
 AGG.val_pr_diff_net_fa_sfo_asis,
 AGG.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_wh_org_day_sig_sfo_asis_2 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON AGG.client_id = WH.client_id AND AGG.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;

