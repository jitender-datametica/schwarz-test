CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_cal_month_1 (
cy_month BIGNUMERIC(38,0) NOT NULL,
prev_month BIGNUMERIC(38,0) NOT NULL,
prev_cy_month BIGNUMERIC(38,0) NOT NULL,
preprev_cy_month BIGNUMERIC(38,0) NOT NULL,
cy BIGNUMERIC(38,0) NOT NULL,
busyear BIGNUMERIC(38,0) NOT NULL,
cy_month_sequence BIGNUMERIC(38,0) NOT NULL,
month_id BIGNUMERIC(38,0) NOT NULL
);