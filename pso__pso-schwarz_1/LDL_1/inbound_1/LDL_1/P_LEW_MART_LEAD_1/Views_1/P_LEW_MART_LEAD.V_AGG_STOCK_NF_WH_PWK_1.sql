CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STOCK_NF_WH_PWK_1
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
   wk.curr_cd                                                       AS curr_cd,
   wk.dwh_cal_dt                                                    AS dwh_cal_dt,
   wk.cy_week_id                                                    AS cy_week_id,
   wk.cy_week_partial_week_id                                       AS cy_week_partial_week_id,
   wk.cy_week_partial_week_id2                                      AS cy_week_partial_week_id2,
   wk.cy_month_id                                                   AS cy_month_id,
   wk.byr                                                           AS byr,
   wk.stock_wh_asis                                                 AS stock_wh_wk_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_wk_pyd) ) AS stock_wh_wk_pyd,
   wk.stock_wh_asis                                                 AS stock_wh_mth_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_scdp1y) ) AS stock_wh_mth_pyd,
   wk.stock_wh_asis                                                 AS stock_wh_yr_asis,
   (ZEROIFNULL(wk.stock_wh_asis) - ZEROIFNULL(wk.stock_wh_scdp1y) ) AS stock_wh_yr_pyd,
   wk.stock_wh_wk_pyd                                               AS stock_wh_wk_p1y,
   wk.stock_wh_scdp1y                                               AS stock_wh_mth_p1y,
   wk.stock_wh_scdp1y                                               AS stock_wh_yr_p1y

  FROM p_lew_mart_lead.t_stock_wh_pwk_agg_base_nf_1 AS wk
;