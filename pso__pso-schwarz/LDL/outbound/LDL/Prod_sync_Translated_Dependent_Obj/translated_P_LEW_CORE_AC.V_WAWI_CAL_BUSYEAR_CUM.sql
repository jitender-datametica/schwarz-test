CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_busyear_cum (dat_calendar, busyear, dat_busyear_cum,
dat_busyear_cum_py, dat_busyear_cum_ppy, cy_by_cum_sequence) AS SELECT *
FROM ldl_p_lew_core.t_wawi_cal_busyear_cum;