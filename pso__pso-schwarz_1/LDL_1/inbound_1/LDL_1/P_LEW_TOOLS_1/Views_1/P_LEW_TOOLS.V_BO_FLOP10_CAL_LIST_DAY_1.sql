CREATE OR REPLACE VIEW P_LEW_TOOLS.V_BO_FLOP10_CAL_LIST_DAY_1
AS
   select
         cal.cal_dt,
      to_number(to_varchar(cal.cal_dt,'YYYYMMDD')) as cal_dt_int,
   cal.cy_week,
   cal.cy_month,
   cal.cy_week_seq,
   cal.cy_month_seq,
   CASE WHEN cal.cy_week_seq BETWEEN -1 AND 0 THEN 1 ELSE 0 END                                          AS day_range_fg,
   CASE WHEN cal.cy_week_seq BETWEEN -4 AND 0
                     OR cal.cy_week_seq BETWEEN -4 - 52 AND 5 - 52 THEN 1 ELSE 0 END                          AS week_range_fg,
   CASE WHEN cal.cy_month_seq BETWEEN -1 AND 0 THEN 1 ELSE 0 END                                         AS month_range_fg
  from p_lew_CORE_AC.v_cal_calendarday_1 cal
   WHERE cy_week_seq BETWEEN -4 AND 0
    OR cy_week_seq BETWEEN -4 - 52 AND 5 - 52
    or cy_month_seq BETWEEN -1 AND 0;