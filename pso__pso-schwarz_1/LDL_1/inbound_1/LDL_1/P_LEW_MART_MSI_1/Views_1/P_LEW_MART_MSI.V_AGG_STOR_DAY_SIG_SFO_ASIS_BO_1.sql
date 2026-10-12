CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STOR_DAY_SIG_SFO_ASIS_BO_1
 /* 
 #DescStart# 
 #$Revision: 6244 $, $LastChangedBy: hwieber $ 
 #SubjectAreas#: 
 #DescEnd# 
 */
(
  store_id
, client_id
, subitemgroup_id
, dat_formdate
, cy_month
, sfotype_id
, pcwo_reason_id
, orig_store_nr
, qty_total_sfo_asis
, qty_total_sfo_wrtoff_zero_asis
, val_rtl_rl_sfo_asis
, val_rtl_rl_net_sfo_asis
, val_wrtoff_zero_asis
, val_wrtoff_zero_net_asis
)
AS
   SELECT
     st_loc_sid               AS store_id,
   client_id,
   subitemgroup_id,
   dat_formdate,
   cy_month,
   sfotype_id,
   pcwo_reason_id,
   orig_store_nr,
   qty_total_sfo_asis,
   qty_total_sfo_wrtoff_zero_asis,
   val_rtl_rl_sfo_asis,
   val_rtl_rl_net_sfo_asis  AS val_rtl_rl_net_sfo_asis,
   val_wrtoff_zero_asis,
   val_wrtoff_zero_net_asis AS  val_wrtoff_zero_net_asis
  FROM p_lew_core_ac.v_wawi_agg_store_day_sig_sfo_asis_1;