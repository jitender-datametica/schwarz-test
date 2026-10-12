CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WH_WK_FA_COVERAGE_1
AS
   SELECT
     wk.cy_week_partial_week_id  AS cy_week_partial_week_id,
   wk.cy_week_partial_week_id2 AS cy_week_partial_week_id2,
   wk.client_id                AS client_id,
   wk.wh_id                    AS wh_id,
   wk.byr                      AS byr,
   wk.month_id                 AS month_id,
   wk.week_id                  AS week_id,
   wk.working_dat              AS working_dat,
   wk.currency_iso_cd          AS currency_iso_cd,
   wk.fa_stock_wh_wk_asis      AS fa_stock_wh_wk_asis,
   wk.fa_stock_wh_wk_pyd       AS fa_stock_wh_wk_pyd,
   wk.fa_stock_wh_mth_asis     AS fa_stock_wh_mth_asis,
   wk.fa_stock_wh_mth_pyd      AS fa_stock_wh_mth_pyd,
   wk.fa_retail_mth_pm         AS fa_retail_mth_pm,
   wk.fa_retail_mth_pmpy       AS fa_retail_mth_pmpy,
   wk.fa_stock_wh_yr_asis      AS fa_stock_wh_yr_asis,
   wk.fa_stock_wh_yr_pyd       AS fa_stock_wh_yr_pyd,
   wk.fa_stock_wh_wk_p1y       AS fa_stock_wh_wk_p1y,
   wk.fa_stock_wh_mth_p1y      AS fa_stock_wh_mth_p1y,
   wk.fa_stock_wh_yr_p1y       AS fa_stock_wh_yr_p1y,
   wk.fa_coverage_wk_asis      AS fa_coverage_wk_asis,
   wk.fa_coverage_mth_asis     AS fa_coverage_mth_asis,
   wk.fa_coverage_yr_asis      AS fa_coverage_yr_asis,
   wk.fa_coverage_wk_pyd       AS fa_coverage_wk_pyd,
   wk.fa_coverage_mth_pyd      AS fa_coverage_mth_pyd,
   wk.fa_coverage_yr_pyd       AS fa_coverage_yr_pyd,
   wk.loc_sid_wh               AS loc_sid_wh

  FROM p_lew_mart_lead.v_agg_wh_wk_fa_coverage_1 AS wk
;