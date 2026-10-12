CREATE OR REPLACE view P_LEW_BIL.V_MAT_AGG_STORE_DAY_SFO_2 as
   /*	
   #DescStart#	
   #$Revision: 7378 $, $LastChangedBy: mueding $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd#	
   */	
   SELECT	
      client_id,	
   loc_sid_store,	
   src_orig_store_nr,	
   booking_dat,	
   cy_week,	
   cy_month,	
   sfotype_id,	
   pcwo_reason_id,	
   SUM(sfo_total_qty) AS sfo_total_qty,	
   SUM(sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,	
   SUM(sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,	
   SUM(sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,	
   SUM(val_pr_diff_sfo) AS val_pr_diff_sfo,	
   SUM(val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,	
   SUM(sfo_total_fa_qty) AS sfo_total_fa_qty,	
   SUM(sfo_wrtoff_zero_fa_qty) AS sfo_wrtoff_zero_fa_qty,	
   SUM(sfo_total_rtl_rl_fa_val) AS sfo_total_rtl_rl_fa_val,	
   SUM(sfo_total_rtl_rl_net_fa_val) AS sfo_total_rtl_rl_net_fa_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_fa_val) AS sfo_wrtoff_zero_rtl_rl_fa_val,	
   SUM(sfo_wrtoff_zero_rtl_rl_net_fa_val) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,	
   SUM(val_pr_diff_fa_sfo) AS val_pr_diff_fa_sfo,	
   SUM(val_pr_diff_net_fa_sfo) AS val_pr_diff_net_fa_sfo,	
   cast(current_timestamp as TIMESTAMP)  AS timestamp_mod	
   FROM p_lew_bil.v_agg_store_day_sig_sfo_2	
   GROUP BY	
      client_id	
     ,loc_sid_store	
     ,src_orig_store_nr	
     ,booking_dat	
     ,cy_week	
     ,cy_month	
     ,sfotype_id	
     ,pcwo_reason_id	
;