CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_busyear_cum (dat_calendar, dat_byr_cum, prev_dat_byr_cum,
dat_busyear_cum_ppy, byr, cy_by_cum_sequence) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_busyear_cum;