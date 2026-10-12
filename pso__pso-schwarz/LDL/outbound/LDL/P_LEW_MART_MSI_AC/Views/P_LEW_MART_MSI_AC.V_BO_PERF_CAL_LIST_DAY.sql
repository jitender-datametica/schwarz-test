/* #DescStart#
#$Revision: 7991 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_perf_cal_list_day (cal_dt, cy_week, cy_week_seq, cy_month,
py_caldt_shifted, py_week_shifted, py_week_seq_shifted, is_daily_level_row, is_weekly_normal_level_row,
is_weekly_pyshift_level_row, is_monthly_level_row) AS SELECT *
FROM ldl_p_lew_mart_msi.v_bo_perf_cal_list_day;