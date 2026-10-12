CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_cal_busyear_cum_1 (
dat_calendar DATE NOT NULL,
busyear BIGNUMERIC(38,0) NOT NULL,
dat_busyear_cum DATE NOT NULL,
dat_busyear_cum_py DATE,
dat_busyear_cum_ppy DATE,
cy_by_cum_sequence BIGNUMERIC(38,0) NOT NULL
);