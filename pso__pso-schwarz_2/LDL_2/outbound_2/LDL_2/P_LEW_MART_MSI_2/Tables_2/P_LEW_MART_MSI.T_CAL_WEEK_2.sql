CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_cal_week_2 (
cy_week BIGNUMERIC(38,0) NOT NULL,
prev_week BIGNUMERIC(38,0) NOT NULL,
prev_cy_week BIGNUMERIC(38,0),
preprev_cy_week BIGNUMERIC(38,0),
cy_week_name STRING(100) COLLATE 'und:ci',
cy_week_short_name STRING(100) COLLATE 'und:ci',
cy_week_sequence BIGNUMERIC(38,0) NOT NULL
);