CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_35_prev_day (dat_calendar, dat_calendar_35_prev_day) AS SELECT
 dat_calendar,
 dat_calendar_35_prev_day
FROM ldl_p_lew_core.t_wawi_cal_35_prev_day;