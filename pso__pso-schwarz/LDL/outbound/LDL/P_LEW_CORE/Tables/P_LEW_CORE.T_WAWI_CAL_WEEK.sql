CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_cal_week (
cy_week BIGNUMERIC(38,0) NOT NULL,
prev_week BIGNUMERIC(38,0) NOT NULL,
prev_cy_week BIGNUMERIC(38,0),
preprev_cy_week BIGNUMERIC(38,0),
cy_week_sequence BIGNUMERIC(38,0) NOT NULL
);