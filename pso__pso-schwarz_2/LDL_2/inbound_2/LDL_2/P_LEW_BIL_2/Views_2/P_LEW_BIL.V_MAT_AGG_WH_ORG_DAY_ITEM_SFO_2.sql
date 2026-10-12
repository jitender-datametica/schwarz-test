CREATE OR REPLACE view P_LEW_BIL.V_MAT_AGG_WH_ORG_DAY_ITEM_SFO_2 as
   /*	
   #DescStart#	
   #$Revision: 14032 $, $LastChangedBy: knagmote $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd#	
   */	
   SELECT	
    sfo.client_id,	
   loc.loc_sid AS loc_sid_wh,	
   org.aspect_id,	
   sfo.booking_dat,	
   sfo.cy_week,	
   sfo.cy_month,	
   sfo.item_sid,	
   sfo.sfotype_id,	
   sfo.pcwo_reason_id,	
   SUM(sfo.sfo_total_qty) AS sfo_total_qty,	
   SUM(sfo.sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,	
   SUM(sfo.sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,	
   SUM(sfo.sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,	
   SUM(sfo.sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,	
   SUM(sfo.sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,	
   SUM(sfo.val_pr_diff_sfo) AS val_pr_diff_sfo,	
   SUM(sfo.val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_qty                     ELSE NULL END) AS sfo_total_fa_qty,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_qty               ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_val              ELSE NULL END) AS sfo_total_rtl_rl_fa_val,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_net_val          ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_val        ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val    ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_sfo                   ELSE NULL END) AS val_pr_diff_fa_sfo,	
   SUM(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_net_sfo               ELSE NULL END) AS val_pr_diff_net_fa_sfo,	
   CAST(CURRENT_TIMESTAMP AS TIMESTAMP)  AS timestamp_mod	
	
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 sfo	
   INNER JOIN p_lew_bil_ac.v_org_store_merge_2 org	
   ON    sfo.client_id     = org.client_id	
   AND   sfo.loc_sid_store = org.loc_sid_store	
   INNER JOIN p_lew_core_ac.v_location_2 loc	
   ON    org.loc_sid_wh    = loc.loc_sid	
   AND   sfo.client_id     = loc.client_id	
   AND   loc.wh_store_mark = 'B'	
	
GROUP BY	
sfo.client_id	
,loc.loc_sid	
,org.aspect_id	
,sfo.booking_dat	
,sfo.cy_week	
,sfo.cy_month	
,sfo.item_sid	
,sfo.sfotype_id	
,sfo.pcwo_reason_id	
;