CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_cal_advweek_partial_week_rel_1 (
cy_week BIGNUMERIC(38,0) NOT NULL,
cy_week_partial_week_id1 BIGNUMERIC(38,0) NOT NULL,
cy_week_partial_week_id2 BIGNUMERIC(38,0) NOT NULL,
cy_week_partial_week_name STRING(100) COLLATE 'und:ci',
cy_month BIGNUMERIC(38,0) NOT NULL,
byr BIGNUMERIC(38,0) NOT NULL,
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL
);