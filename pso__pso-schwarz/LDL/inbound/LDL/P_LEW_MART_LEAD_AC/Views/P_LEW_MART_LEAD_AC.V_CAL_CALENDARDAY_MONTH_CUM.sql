CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CAL_CALENDARDAY_MONTH_CUM
(
    cal_dt
  , cal_dt_month_cum
  , cy
  , cy_month
  , cy_week
  , day_of_cy
  , day_of_month
  , day_of_week
)
AS
   SELECT
       cal_dt,
   cal_dt_month_cum,
   cy,
   cy_month,
   cy_week,
   day_of_cy,
   day_of_month,
   day_of_week
  FROM p_lew_mart_lead.v_cal_calendarday_month_cum
;