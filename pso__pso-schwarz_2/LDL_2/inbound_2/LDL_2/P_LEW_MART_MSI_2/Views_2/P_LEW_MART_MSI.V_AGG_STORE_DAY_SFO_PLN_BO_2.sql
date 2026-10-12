CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_DAY_SFO_PLN_BO_2 as
   /* 
   #DescStart# 
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 
   #SubjectAreas#: Kleinbelege / Storeforms 
   #DescEnd# 
   */
   SELECT
   a.st_loc_sid AS store_id,
   a.client_id,
   a.dat_formdate,
   a.cy_month,
   a.sfotype_id,
   a.orig_store_nr,
   a.qty_total_sfo,
   a.qty_total_sfo_wrtoff_zero,
   a.val_rtl_rl_sfo,
   a.val_rtl_rl_net_sfo   AS val_rtl_rl_net_sfo,
   a.val_wrtoff_zero,
   a.val_wrtoff_zero_net  AS val_wrtoff_zero_net
  FROM p_lew_core_ac.v_wawi_agg_store_day_sfo_2 AS a;