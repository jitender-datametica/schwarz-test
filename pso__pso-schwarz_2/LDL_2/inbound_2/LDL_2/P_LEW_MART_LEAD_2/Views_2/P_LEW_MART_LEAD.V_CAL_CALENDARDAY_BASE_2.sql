CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_CAL_CALENDARDAY_BASE_2
(
   dat_calendar
   , prev_dat_calendar
   , pwd_dat_calendar
   , prev_cy_dat_calendar
   , preprev_cy_dat_calendar
   , day_of_week
   , day_of_month
   , day_of_cy
   , cy_week
   , cy_partial_week
   , cy_month
   , cy
   , byr
   , cy_day_sequence
   , prev_cy_dat_calendar_samewday
   , prev_cy_prev_week_samewday
   , cy_week_99
   , cy_month_sequence
   , cy_week_sequence
   , pmd_dat_calendar
   , pyd_dat_calendar
   , ppy_dat_calendar
   , first_dat_calendar_next_week
)
AS
   SELECT

   cal_dt AS dat_calendar,
   cal_dt_prev_1d AS prev_dat_calendar,
   cal_dt_prev_7d AS pwd_dat_calendar,
   cal_dt_prev_1y AS prev_cy_dat_calendar,
   cal_dt_prev_2y AS preprev_cy_dat_calendar,
   day_of_week,
   day_of_month,
   day_of_cy,
   cy_week,
   cy_week_part AS cy_partial_week,
   cy_month,
   cy,
   busyear    AS byr,
   cy_day_seq AS cy_day_sequence,
   cal_dt_swday_prev_1y    AS prev_cy_dat_calendar_samewday,
   cal_dt_swday_prev_1y_1w AS prev_cy_prev_week_samewday,
   cy_week_99,
   cy_month_seq AS cy_month_sequence,
   cy_week_seq  AS cy_week_sequence,
   cal_dt_prev_md AS pmd_dat_calendar,
   cal_dt_prev_yd AS pyd_dat_calendar,
   cal_dt_prev_py AS ppy_dat_calendar,
   cal_dt_first_day_next_1w AS first_dat_calendar_next_week
   FROM p_lew_core_ac.v_cal_calendarday_2
  WHERE cy < (SELECT
   Max(a.cy)-6
   FROM p_lew_core_ac.v_cal_calendarday_2 a)
;