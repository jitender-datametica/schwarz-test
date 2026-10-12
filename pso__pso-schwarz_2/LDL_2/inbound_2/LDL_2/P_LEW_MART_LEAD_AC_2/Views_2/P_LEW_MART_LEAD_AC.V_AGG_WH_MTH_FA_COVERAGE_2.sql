CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WH_MTH_FA_COVERAGE_2
AS
   SELECT

     client_id,
   gl_region_id,
   wh_loc_sid,
   wh_id,
   cy_week_partial_week_id,
   month_id,
   byr,
   currency_iso_cd,
   stock_mth_asis,
   stock_mth_PY,
   revenue_mth_asis,
   revenue_mth_PY,
   coverage_mth_wh_asis,
   coverage_mth_wh_py
  FROM p_lew_mart_lead.t_agg_wh_mth_fa_coverage_2

;