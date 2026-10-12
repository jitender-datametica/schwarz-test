CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_cal_month_ber_1 (
dat_calendar_amd DATE NOT NULL,
dat_calendar_pmd DATE,
dat_calendar_pyd DATE,
dat_calendar_pypm DATE,
dat_calendar_ppy DATE,
dat_calendar_pppy DATE,
cy_month BIGNUMERIC(38,0) NOT NULL,
prev_month BIGNUMERIC(38,0) NOT NULL
);