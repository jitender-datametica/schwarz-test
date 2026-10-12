CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_STOCK_WH_PWK_AGG_BASE_FA
AS
   SELECT
     fa.client_id                AS client_id,
   fa.src_wh_id                AS src_wh_id,
   fa.loc_sid_wh               AS loc_sid_wh,
   fa.curr_cd                  AS curr_cd,
   fa.dwh_cal_dt               AS dwh_cal_dt,
   fa.cy_week_id               AS cy_week_id,
   fa.cy_week_partial_week_id  AS cy_week_partial_week_id,
   fa.cy_week_partial_week_id2 AS cy_week_partial_week_id2,
   fa.cy_month_id              AS cy_month_id,
   fa.byr                      AS byr,
   fa.last_day_of_wk_fg        AS last_day_of_wk_fg,
   fa.last_day_month_fg        AS last_day_month_fg,
   fa.stock_wh_asis            AS stock_wh_asis,
   fa.stock_wh_scdp1y          AS stock_wh_scdp1y,
   fa.stock_wh_wk_pyd          AS stock_wh_wk_pyd
  FROM p_lew_mart_lead.t_stock_wh_pwk_agg_base_fa AS fa
;