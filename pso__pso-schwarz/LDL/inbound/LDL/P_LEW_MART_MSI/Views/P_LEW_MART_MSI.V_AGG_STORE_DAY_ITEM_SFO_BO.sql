CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_SFO_BO
 /* 
 #DescStart# 
 #$Revision: 6244 $, $LastChangedBy: hwieber $ 
 #SubjectAreas#: 
 #DescEnd# 
 */
(
  store_id
, client_id
, item_id
, dat_formdate
, cy_month
, sfotype_id
, orig_store_nr
, qty_total_sfo
, qty_total_sfo_wrtoff_zero
, val_rtl_rl_sfo
, val_wrtoff_zero
, val_total_wh_sfo
, val_total_str_sfo
)
AS
   SELECT
     st_loc_sid              AS     store_id,
   client_id,
   item_sid                AS     item_id,
   dat_formdate,
   cy_month,
   sfotype_id,
   orig_store_nr,
   qty_total_sfo,
   qty_total_sfo_wrtoff_zero,
   val_rtl_rl_sfo,
   val_wrtoff_zero,
   val_total_wh_sfo,
   val_total_str_sfo
  FROM p_lew_core_ac.v_wawi_agg_store_day_item_sfo;