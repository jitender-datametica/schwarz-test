/* #DescStart#	
   #$Revision: 14032 $, $LastChangedBy: knagmote $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_wh_org_day_item_sfo_1 AS SELECT SFO.client_id,
 LOC.loc_sid AS loc_sid_wh,
 ORG.aspect_id,
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
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS timestamp_mod
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1 AS SFO
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS ORG ON SFO.client_id = ORG.client_id AND SFO.loc_sid_store = ORG.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON ORG.loc_sid_wh = LOC.loc_sid AND SFO.client_id = LOC.client_id AND
   LOC.wh_store_mark = 'B'
GROUP BY SFO.client_id,
 loc_sid_wh,
 ORG.aspect_id,
 SFO.booking_dat,
 SFO.cy_week,
 SFO.cy_month,
 SFO.item_sid,
 SFO.sfotype_id,
 SFO.pcwo_reason_id;