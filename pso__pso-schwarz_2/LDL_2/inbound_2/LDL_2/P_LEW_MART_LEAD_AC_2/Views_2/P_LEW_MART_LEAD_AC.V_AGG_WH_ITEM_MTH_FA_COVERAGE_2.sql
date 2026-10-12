CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WH_ITEM_MTH_FA_COVERAGE_2
AS
   SELECT

     client_id,
   wh_loc_sid,
   wh_id,
   item_sid,
   src_itemgrp_int_cd,
   cy_week_partial_week_id,
   month_id,
   byr,
   currency_iso_cd,
   stock_mth_asis,
   stock_mth_PY,
   revenue_mth_asis,
   revenue_mth_PY,
   coverage_mth_item_asis,
   coverage_mth_item_py
  FROM p_lew_mart_lead.t_agg_wh_item_mth_fa_coverage_2

;