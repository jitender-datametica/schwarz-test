CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_cal_holiday_desc_1 (
country_id BIGNUMERIC(38,0) NOT NULL,
dat_holiday DATE NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
holiday_desc STRING(50) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);