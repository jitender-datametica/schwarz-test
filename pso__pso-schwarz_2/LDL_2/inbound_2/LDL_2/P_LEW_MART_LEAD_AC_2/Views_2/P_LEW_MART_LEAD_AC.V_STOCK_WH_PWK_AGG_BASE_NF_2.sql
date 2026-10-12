CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_STOCK_WH_PWK_AGG_BASE_NF_2
AS
   SELECT
     nf.client_id                AS client_id,
   nf.src_wh_id                AS src_wh_id,
   nf.loc_sid_wh               AS loc_sid_wh,
   nf.curr_cd                  AS curr_cd,
   nf.dwh_cal_dt               AS dwh_cal_dt,
   nf.cy_week_id               AS cy_week_id,
   nf.cy_week_partial_week_id  AS cy_week_partial_week_id,
   nf.cy_week_partial_week_id2 AS cy_week_partial_week_id2,
   nf.cy_month_id              AS cy_month_id,
   nf.byr                      AS byr,
   nf.last_day_of_wk_fg        AS last_day_of_wk_fg,
   nf.last_day_month_fg        AS last_day_month_fg,
   nf.stock_wh_asis            AS stock_wh_asis,
   nf.stock_wh_scdp1y          AS stock_wh_scdp1y,
   nf.stock_wh_wk_pyd          AS stock_wh_wk_pyd
  FROM p_lew_mart_lead.t_stock_wh_pwk_agg_base_nf_2 AS nf
;