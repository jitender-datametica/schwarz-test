/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_cal_calendarday
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_cal_calendarday for calendar dates
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_cal_calendarday (cal_dt, mstr_day_of_week, day_of_week, day_of_month,
day_of_cy, cy, cy_week, cy_week_99, cy_week_part, cy_month, cy_month_prev_1m, busyear, cal_dt_prev_1d, cal_dt_prev_7d,
cal_dt_prev_1y, cal_dt_prev_2y, cal_dt_prev_3y, cal_dt_prev_4y, cal_dt_prev_5y, cal_dt_prev_yd, cal_dt_prev_md,
cal_dt_prev_py, cal_dt_swday_prev_1y, cal_dt_swday_prev_2y, cal_dt_swday_prev_3y, cal_dt_swday_prev_4y,
cal_dt_swday_prev_5y, cal_dt_swday_prev_1y_1w, cal_dt_last_day_prev_1w, cal_dt_last_day_prev_1m, cal_dt_last_day_prev_1y
, cal_dt_first_day_next_1w, last_day_week_fg, last_day_week_partial_fg, last_day_month_fg, last_day_year_fg, cy_day_seq
, cy_week_seq, cy_month_seq, busyear_seq, dwh_load_id, dwh_created, dwh_src)
OPTIONS(DESCRIPTION = `CALENDAR HIERARCHY MASTER DATA - VIEW BASED ON MV_CAL_CALENDARDAY`) AS SELECT cal_dt,
  CASE
  WHEN day_of_week = 7
  THEN 1
  WHEN day_of_week = 1
  THEN 2
  WHEN day_of_week = 2
  THEN 3
  WHEN day_of_week = 3
  THEN 4
  WHEN day_of_week = 4
  THEN 5
  WHEN day_of_week = 5
  THEN 6
  ELSE 7
  END AS mstr_day_of_week,
 day_of_week,
 day_of_month,
 day_of_cy,
 cy,
 cy_week,
 cy_week_99,
 cy_week_part,
 cy_month,
 cy_month_prev_1m,
 busyear,
 cal_dt_prev_1d,
 cal_dt_prev_7d,
 cal_dt_prev_1y,
 cal_dt_prev_2y,
 cal_dt_prev_3y,
 cal_dt_prev_4y,
 cal_dt_prev_5y,
 cal_dt_prev_yd,
 cal_dt_prev_md,
 cal_dt_prev_py,
 cal_dt_swday_prev_1y,
 cal_dt_swday_prev_2y,
 cal_dt_swday_prev_3y,
 cal_dt_swday_prev_4y,
 cal_dt_swday_prev_5y,
 cal_dt_swday_prev_1y_1w,
 cal_dt_last_day_prev_1w,
 cal_dt_last_day_prev_1m,
 cal_dt_last_day_prev_1y,
 cal_dt_first_day_next_1w,
 last_day_week_fg,
 last_day_week_partial_fg,
 last_day_month_fg,
 last_day_year_fg,
 cy_day_seq,
 cy_week_seq,
 cy_month_seq,
 busyear_seq,
 dwh_load_id,
 dwh_created,
 dwh_src
FROM ldl_logop_data.t_cal_calendarday;