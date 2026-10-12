CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day AS SELECT cal_dt,
 ROUND(CAST(FORMAT_DATE('%Y%m%d', cal_dt) AS BIGNUMERIC), 0) AS cal_dt_int,
 cy_week,
 cy_month,
 cy_week_seq,
 cy_month_seq,
  CASE
  WHEN cy_week_seq BETWEEN - 1 AND 0
  THEN 1
  ELSE 0
  END AS day_range_fg,
  CASE
  WHEN cy_week_seq BETWEEN - 4 AND 0 OR cy_week_seq BETWEEN - 4 - 52 AND (5 - 52)
  THEN 1
  ELSE 0
  END AS week_range_fg,
  CASE
  WHEN cy_month_seq BETWEEN - 1 AND 0
  THEN 1
  ELSE 0
  END AS month_range_fg
FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
WHERE cy_week_seq BETWEEN - 4 AND 0
 OR cy_week_seq BETWEEN - 4 - 52 AND (5 - 52)
 OR cy_month_seq BETWEEN - 1 AND 0;