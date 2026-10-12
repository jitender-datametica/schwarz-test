CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_PRSNL_COSTS_STR_MTH_2
AS
   SELECT
         pc.client_id,
   pc.loc_sid_store_move_to,
   pc.aspect_id,
   pc.currency_iso_cd,
   pc.cy_month,
   pc.busyear,
   pc.rev_mtd_val,
   pc.prev1y_rev_mtd_val,
   pc.rev_bytd_val,
   pc.prev1y_rev_bytd_val,
   pc.asis_mtd_val_indicator_216,
   pc.p1y_mtd_val_indicator_216,
   pc.asis_ytd_val_indicator_216,
   pc.p1y_ytd_val_indicator_216,
   pc.asis_prsnl_costs_mtd,
   pc.p1y_prsnl_costs_mtd,
   pc.diff_Prsnl_costs_mtd,
   pc.asis_prsnl_costs_bytd,
   pc.p1y_prsnl_costs_bytd,
   pc.diff_prsnl_costs_bytd
  FROM p_lew_mart_lead.t_agg_prsnl_costs_str_mth_2 pc;