CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_cal_month_desc_1 (
month_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
month_name STRING(50) COLLATE 'und:ci' NOT NULL,
month_name_short STRING(50) COLLATE 'und:ci' NOT NULL
);