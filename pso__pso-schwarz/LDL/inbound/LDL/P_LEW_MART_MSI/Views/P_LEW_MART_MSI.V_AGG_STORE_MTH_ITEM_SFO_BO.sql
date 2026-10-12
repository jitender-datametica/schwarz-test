CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_MTH_ITEM_SFO_BO as
   SELECT
     st_loc_sid             AS store_id,
   client_id,
   item_sid                 AS item_id,
   cy_month,
   sfotype_id,
   orig_store_nr,
   qty_total_sfo,
   qty_total_sfo_wrtoff_zero,
   val_rtl_rl_sfo,
   val_rtl_rl_net_sfo   AS val_rtl_rl_net_sfo,
   val_wrtoff_zero,
   val_wrtoff_zero_net  AS val_wrtoff_zero_net
  FROM p_lew_core_ac.v_wawi_agg_store_mth_item_sfo;