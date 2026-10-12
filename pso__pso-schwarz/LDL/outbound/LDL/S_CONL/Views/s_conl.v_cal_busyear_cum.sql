CREATE OR REPLACE VIEW ldl_s_conl.v_cal_busyear_cum AS SELECT dat_calendar,
 dat_busyear_cum AS dat_byr_cum,
 dat_busyear_cum_py AS prev_dat_byr_cum,
 dat_busyear_cum_ppy,
 busyear AS byr,
 cy_by_cum_sequence
FROM ldl_p_lew_core_ac.v_wawi_cal_busyear_cum;