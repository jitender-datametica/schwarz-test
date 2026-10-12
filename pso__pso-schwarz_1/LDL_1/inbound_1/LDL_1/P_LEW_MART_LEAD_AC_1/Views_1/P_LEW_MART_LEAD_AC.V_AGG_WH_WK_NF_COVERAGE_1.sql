CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WH_WK_NF_COVERAGE_1
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
   wk.nf_stock_wh_wk_asis      AS nf_stock_wh_wk_asis,
   wk.nf_stock_wh_wk_pyd       AS nf_stock_wh_wk_pyd,
   wk.nf_stock_wh_mth_asis     AS nf_stock_wh_mth_asis,
   wk.nf_stock_wh_mth_pyd      AS nf_stock_wh_mth_pyd,
   wk.nf_retail_mth_pm         AS nf_retail_mth_pm,
   wk.nf_retail_mth_pmpy       AS nf_retail_mth_pmpy,
   wk.nf_stock_wh_yr_asis      AS nf_stock_wh_yr_asis,
   wk.nf_stock_wh_yr_pyd       AS nf_stock_wh_yr_pyd,
   wk.nf_stock_wh_wk_p1y       AS nf_stock_wh_wk_p1y,
   wk.nf_stock_wh_mth_p1y      AS nf_stock_wh_mth_p1y,
   wk.nf_stock_wh_yr_p1y       AS nf_stock_wh_yr_p1y,
   wk.nf_coverage_wk_asis      AS nf_coverage_wk_asis,
   wk.nf_coverage_mth_asis     AS nf_coverage_mth_asis,
   wk.nf_coverage_yr_asis      AS nf_coverage_yr_asis,
   wk.nf_coverage_wk_pyd       AS nf_coverage_wk_pyd,
   wk.nf_coverage_mth_pyd      AS nf_coverage_mth_pyd,
   wk.nf_coverage_yr_pyd       AS nf_coverage_yr_pyd,
   wk.loc_sid_wh               AS loc_sid_wh

  FROM p_lew_mart_lead.v_agg_wh_wk_nf_coverage_1 AS wk
;