/* #DescStart#	
   #$Revision: 8040 $, $LastChangedBy: mlysik $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_wh_day_item_sfo_1 AS SELECT SFO.client_id,
 STWH.loc_sid_wh,
 1 AS aspect_id,
 SFO.booking_dat,
 SFO.cy_week,
 SFO.cy_month,
 SFO.item_sid,
 SFO.sfotype_id,
 SFO.pcwo_reason_id,
 SUM(SFO.sfo_total_qty) AS sfo_total_qty,
 SUM(SFO.sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,
 SUM(SFO.sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
 SUM(SFO.sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,
 SUM(SFO.val_pr_diff_sfo) AS val_pr_diff_sfo,
 SUM(SFO.val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_total_qty
   ELSE NULL
   END) AS sfo_total_fa_qty,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_wrtoff_zero_qty
   ELSE NULL
   END) AS sfo_wrtoff_zero_fa_qty,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_total_rtl_rl_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_fa_val,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_total_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_total_rtl_rl_net_fa_val,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_wrtoff_zero_rtl_rl_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.sfo_wrtoff_zero_rtl_rl_net_val
   ELSE NULL
   END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.val_pr_diff_sfo
   ELSE NULL
   END) AS val_pr_diff_fa_sfo,
 SUM(CASE
   WHEN SFO.foodaction_fg = 1
   THEN SFO.val_pr_diff_net_sfo
   ELSE NULL
   END) AS val_pr_diff_net_fa_sfo,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1 AS SFO
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown_1 AS STWH ON SFO.client_id = STWH.client_id AND SFO.loc_sid_store
    = STWH.loc_sid_store
GROUP BY SFO.client_id,
 STWH.loc_sid_wh,
 SFO.booking_dat,
 SFO.cy_week,
 SFO.cy_month,
 SFO.item_sid,
 SFO.sfotype_id,
 SFO.pcwo_reason_id;