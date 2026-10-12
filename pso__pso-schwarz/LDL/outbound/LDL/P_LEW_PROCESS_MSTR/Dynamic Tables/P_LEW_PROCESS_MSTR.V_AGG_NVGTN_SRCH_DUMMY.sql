CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_agg_nvgtn_srch_dummy AS
SELECT C.cy_month,
 d.cy_week,
 1 AS one_week_fg
FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday AS C
 INNER JOIN (SELECT cy_week
  FROM ldl_p_lew_mart_msi_ac.v_cal_week
  WHERE cy_week_sequence = - 499) AS d ON C.dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);