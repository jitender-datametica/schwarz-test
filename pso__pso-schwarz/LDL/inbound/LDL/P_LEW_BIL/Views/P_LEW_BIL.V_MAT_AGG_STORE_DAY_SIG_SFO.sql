CREATE OR REPLACE view P_LEW_BIL.V_MAT_AGG_STORE_DAY_SIG_SFO as
   SELECT	
     sfo.client_id,	
   sfo.loc_sid_store,	
   sfo.src_orig_store_nr,	
   sfo.booking_dat,	
   sfo.cy_week,	
   sfo.cy_month,	
   CAST(TO_NUMBER(ih.src_subitemgrp_cd) AS INTEGER)                                    AS subitemgroup_id,	
   sfo.sfotype_id,	
   sfo.pcwo_reason_id,	
   SUM(sfo_total_qty )                                                                   AS sfo_total_qty,	
   SUM(sfo_wrtoff_zero_qty)                                                              AS sfo_wrtoff_zero_qty,	
   SUM(sfo_total_rtl_rl_val)                                                             AS sfo_total_rtl_rl_val,	
   SUM(sfo_total_rtl_rl_net_val)                                                         AS sfo_total_rtl_rl_net_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_val)                                                       AS sfo_wrtoff_zero_rtl_rl_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_net_val)                                                   AS sfo_wrtoff_zero_rtl_rl_net_val,	
   SUM(val_pr_diff_sfo)                                                                  AS val_pr_diff_sfo,	
   SUM(val_pr_diff_net_sfo)                                                              AS val_pr_diff_net_sfo,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_total_qty                     ELSE NULL END) AS sfo_total_fa_qty,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_qty               ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_val              ELSE NULL END) AS sfo_total_rtl_rl_fa_val,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_net_val          ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_val        ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,	
   SUM(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val    ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,	
   SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_sfo                   ELSE NULL END) AS val_pr_diff_fa_sfo,	
   SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_sfo               ELSE NULL END) AS val_pr_diff_net_fa_sfo,	
   cast(current_timestamp as TIMESTAMP)                                               AS timestamp_mod	
	
  FROM p_lew_bil.t_agg_store_day_item_sfo sfo	
   INNER JOIN p_lew_bil.v_item_hierarchy ih	
   ON sfo. client_id = ih.client_id	
   AND sfo.item_sid = ih.item_sid	
	
   GROUP BY	
     sfo.client_id	
   , sfo.loc_sid_store	
   , sfo.src_orig_store_nr	
   , sfo.booking_dat	
   , sfo.cy_week	
   , sfo.cy_month	
   , subitemgroup_id	
   , sfo.sfotype_id	
   , sfo.pcwo_reason_id;