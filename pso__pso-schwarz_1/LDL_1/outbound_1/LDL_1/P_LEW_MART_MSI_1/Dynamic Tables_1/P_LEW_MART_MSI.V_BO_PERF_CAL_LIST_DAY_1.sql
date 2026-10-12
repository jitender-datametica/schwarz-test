
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_bo_perf_cal_list_day_1
AS
SELECT CALDAY.cal_dt,
 CALDAY.cy_week,
 CALDAY.cy_week_seq,
 CALDAY.cy_month,
 CALDAY_PY_WEEK4UMS.cal_dt AS py_caldt_shifted,
 CALDAY_PY_WEEK4UMS.cy_week AS py_week_shifted,
 CALDAY_PY_WEEK4UMS.cy_week_seq AS py_week_seq_shifted,
  CASE
  WHEN SET_OF_WEEKS_FOR_DAILY.cy_week IS NOT NULL
  THEN 1
  ELSE 0
  END AS is_daily_level_row,
  CASE
  WHEN CALDAY.cy_week_seq BETWEEN - 17 AND (- 1) OR CALDAY.cy_week_seq BETWEEN - 52 - 12 - 1 AND (- 52 + 7)
  THEN 1
  ELSE 0
  END AS is_weekly_normal_level_row,
  CASE
  WHEN CALDAY_PY_WEEK4UMS.cal_dt IS NOT NULL
  THEN 1
  ELSE 0
  END AS is_weekly_pyshift_level_row,
 MAX(CASE
   WHEN CALDAY.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_act OR CALDAY.cal_dt
       BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_act OR CALDAY.cal_dt BETWEEN INTVLS
      .min_dat_calendar_month AND INTVLS.max_dat_calendar_month_plan OR CALDAY.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py
     AND INTVLS.max_dat_calendar_month_py_plan
   THEN 1
   ELSE 0
   END) AS is_monthly_level_row
FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CALDAY
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CALDAY_PY_WEEK4UMS ON CALDAY.cal_dt = CALDAY_PY_WEEK4UMS.cal_dt_swday_prev_1y
    AND (CALDAY_PY_WEEK4UMS.cy_week_seq BETWEEN - 17 AND (- 1) OR CALDAY_PY_WEEK4UMS.cy_week_seq BETWEEN - 52 - 12 - 1
     AND (- 52 + 7))
 LEFT JOIN ldl_p_lew_mart_msi.v_bo_perf_cal_list_mth_1 AS SET_OF_WEEKS_FOR_DAILY ON CALDAY.cy_week =
  SET_OF_WEEKS_FOR_DAILY.cy_week
 LEFT JOIN ldl_p_lew_mart_msi.v_bo_perf_cal_list_mth_1 AS INTVLS ON CALDAY.cal_dt BETWEEN INTVLS.min_dat_calendar_month
     AND INTVLS.max_dat_calendar_month_act OR CALDAY.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_act
      OR CALDAY.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_plan OR CALDAY.cal_dt
   BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_plan
WHERE CALDAY_PY_WEEK4UMS.cal_dt IS NOT NULL
 OR SET_OF_WEEKS_FOR_DAILY.cy_week IS NOT NULL
 OR INTVLS.cy_week IS NOT NULL
 OR CALDAY.cy_week_seq BETWEEN - 17 AND (- 1)
 OR CALDAY.cy_week_seq BETWEEN - 52 - 12 - 1 AND (- 52 + 7)
GROUP BY CALDAY.cal_dt,
 CALDAY.cy_week,
 CALDAY.cy_week_seq,
 CALDAY.cy_month,
 py_caldt_shifted,
 py_week_shifted,
 py_week_seq_shifted,
 is_daily_level_row;

