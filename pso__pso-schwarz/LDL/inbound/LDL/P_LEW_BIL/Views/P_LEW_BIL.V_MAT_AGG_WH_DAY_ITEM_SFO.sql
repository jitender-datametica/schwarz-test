CREATE OR REPLACE view P_LEW_BIL.V_MAT_AGG_WH_DAY_ITEM_SFO as
   /*	
   #DescStart#	
   #$Revision: 8040 $, $LastChangedBy: mlysik $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd#	
   */	
   SELECT	
    sfo.client_id,	
   stwh.loc_sid_wh,	
   Cast(1 AS BYTEINT)                                                                            AS aspect_id,	
   sfo.booking_dat,	
   sfo.cy_week,	
   sfo.cy_month,	
   sfo.item_sid,	
   sfo.sfotype_id,	
   sfo.pcwo_reason_id,	
   Sum(sfo.sfo_total_qty)                                                                        AS sfo_total_qty,	
   Sum(sfo.sfo_wrtoff_zero_qty)                                                                  AS sfo_wrtoff_zero_qty,	
   Sum(sfo.sfo_total_rtl_rl_val)                                                                 AS sfo_total_rtl_rl_val,	
   Sum(sfo.sfo_total_rtl_rl_net_val)                                                             AS sfo_total_rtl_rl_net_val,	
   Sum(sfo.sfo_wrtoff_zero_rtl_rl_val)                                                           AS sfo_wrtoff_zero_rtl_rl_val,	
   Sum(sfo.sfo_wrtoff_zero_rtl_rl_net_val)                                                       AS sfo_wrtoff_zero_rtl_rl_net_val,	
   Sum(sfo.val_pr_diff_sfo)                                                                      AS val_pr_diff_sfo,	
   Sum(sfo.val_pr_diff_net_sfo)                                                                  AS val_pr_diff_net_sfo,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_qty                     ELSE NULL END) AS sfo_total_fa_qty,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_qty               ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_val              ELSE NULL END) AS sfo_total_rtl_rl_fa_val,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_total_rtl_rl_net_val          ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_val        ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val    ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_sfo                   ELSE NULL END) AS val_pr_diff_fa_sfo,	
   Sum(CASE WHEN sfo.foodaction_fg = 1 THEN sfo.val_pr_diff_net_sfo               ELSE NULL END) AS val_pr_diff_net_fa_sfo,	
   CURRENT_TIMESTAMP(6)                                                                          AS dwh_updated	
	
   FROM p_lew_bil.t_agg_store_day_item_sfo sfo	
   INNER JOIN p_lew_bil.v_store_to_warehouse_lastknown stwh	
   ON  stwh.client_id = sfo.client_id	
   AND stwh.loc_sid_store = sfo.loc_sid_store	
	
   GROUP BY	
    sfo.client_id	
   ,stwh.loc_sid_wh	
   ,sfo.booking_dat	
   ,sfo.cy_week	
   ,sfo.cy_month	
   ,sfo.item_sid	
   ,sfo.sfotype_id	
   ,sfo.pcwo_reason_id	
;