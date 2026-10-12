CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STOCK_FA_WH_PWK_1
AS
   SELECT
     wk.cy_week_partial_week_id  AS cy_week_partial_week_id,
   wk.cy_week_partial_week_id2 AS cy_week_partial_week_id2,
   wk.client_id                AS client_id,
   wk.wh_id                    AS wh_id,
   wk.loc_sid_wh               AS loc_sid_wh,
   wk.byr                      AS byr,
   wk.cy_month_id              AS cy_month_id,
   wk.cy_week_id               AS cy_week_id,
   wk.dwh_cal_dt               AS dwh_cal_dt,
   wk.curr_cd                  AS curr_cd,
   wk.stock_wh_wk_asis         AS stock_wh_wk_asis,
   wk.stock_wh_wk_pyd          AS stock_wh_wk_pyd,
   wk.stock_wh_mth_asis        AS stock_wh_mth_asis,
   wk.stock_wh_mth_pyd         AS stock_wh_mth_pyd,
   wk.stock_wh_yr_asis         AS stock_wh_yr_asis,
   wk.stock_wh_yr_pyd          AS stock_wh_yr_pyd,
   wk.stock_wh_wk_p1y          AS stock_wh_wk_p1y,
   wk.stock_wh_mth_p1y         AS stock_wh_mth_p1y,
   wk.stock_wh_yr_p1y          AS stock_wh_yr_p1y

  FROM p_lew_mart_lead.v_agg_stock_fa_wh_pwk_1 AS wk
;