CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_WH_WK_FA_COVERAGE_2
AS
   /*
   #DescStart#
   #$Revision: 8711 $, $LastChangedBy: rbarten $
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   #DescEnd#
   */
   SELECT
     wk.client_id                                                     AS client_id,
   wk.src_wh_id                                                     AS wh_id,
   wk.loc_sid_wh                                                    AS loc_sid_wh,
   wk.curr_cd                                                       AS currency_iso_cd,
   wk.dwh_cal_dt                                                    AS working_dat,
   wk.cy_week_id                                                    AS week_id,
   wk.cy_week_partial_week_id                                       AS cy_week_partial_week_id,
   wk.cy_week_partial_week_id2                                      AS cy_week_partial_week_id2,
   wk.cy_month_id                                                   AS month_id,
   wk.byr                                                           AS byr,
   wk.stock_wh_asis                                                 AS fa_stock_wh_wk_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_wk_pyd) ) AS fa_stock_wh_wk_pyd,
   wk.stock_wh_asis                                                 AS fa_stock_wh_mth_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_scdp1y) ) AS fa_stock_wh_mth_pyd,
   CAST(NULL AS DECIMAL(20,8))                                      AS fa_retail_mth_pm,
   CAST(NULL AS DECIMAL(20,8))                                      AS fa_retail_mth_pmpy,
   wk.stock_wh_asis                                                 AS fa_stock_wh_yr_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_scdp1y) ) AS fa_stock_wh_yr_pyd,
   wk.stock_wh_wk_pyd                                               AS fa_stock_wh_wk_p1y,
   wk.stock_wh_scdp1y                                               AS fa_stock_wh_mth_p1y,
   wk.stock_wh_scdp1y                                               AS fa_stock_wh_yr_p1y,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_wk_asis   --4.33 * wk.stock_wh_asis / nullifzero(retail_mth_pm)                       AS coverage_wk_asis
   ,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_mth_asis  --4.33 * wk.stock_wh_asis / nullifzero(retail_mth_pm)                       AS coverage_mth_asis
   ,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_yr_asis   --4.33 * wk.stock_wh_asis / nullifzero(retail_mth_pm)                       AS coverage_yr_asis
   ,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_wk_pyd    --coverage_wk_asis  - 4.33 * stock_wh_wk_p1y  / nullifzero(retail_mth_pmpy) AS coverage_wk_pyd
   ,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_mth_pyd   --coverage_mth_asis - 4.33 * stock_wh_mth_p1y / nullifzero(retail_mth_pmpy) AS coverage_mth_pyd
   ,
   CAST(NULL AS DECIMAL(18,8))                                      AS fa_coverage_yr_pyd    --coverage_yr_asis  - 4.33 * stock_wh_yr_p1y  / nullifzero(retail_mth_pmpy) AS coverage_yr_pyd

  FROM p_lew_mart_lead.t_stock_wh_pwk_agg_base_fa_2 AS wk
;