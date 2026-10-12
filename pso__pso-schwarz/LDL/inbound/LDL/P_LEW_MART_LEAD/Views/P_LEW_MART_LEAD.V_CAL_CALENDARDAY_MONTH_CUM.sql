CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_CAL_CALENDARDAY_MONTH_CUM
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
   SELECT   c1.cal_dt AS cal_dt,
   c2.cal_dt AS cal_dt_month_cum,
   c2.cy,
   c2.cy_month,
   c2.cy_week,
   c2.day_of_cy,
   c2.day_of_month,
   c2.day_of_week
  FROM p_lew_core_ac.v_cal_calendarday c1
   INNER JOIN p_lew_core_ac.v_cal_calendarday c2
   ON                   c2.cy_month = c1.cy_month
   AND                  c2.cal_dt <= c1.cal_dt
;