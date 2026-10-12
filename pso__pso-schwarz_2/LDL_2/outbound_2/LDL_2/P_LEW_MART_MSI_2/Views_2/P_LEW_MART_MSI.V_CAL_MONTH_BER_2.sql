CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_month_ber_2 (dat_calendar_amd, dat_calendar_pmd, dat_calendar_pyd,
dat_calendar_pypm, dat_calendar_ppy, dat_calendar_pppy, cy_month, prev_month) AS SELECT dat_calendar_amd,
 dat_calendar_pmd,
 dat_calendar_pyd,
 dat_calendar_pypm,
 dat_calendar_ppy,
 dat_calendar_pppy,
 cy_month,
 prev_month
FROM ldl_p_lew_mart_msi.t_cal_month_ber_2;