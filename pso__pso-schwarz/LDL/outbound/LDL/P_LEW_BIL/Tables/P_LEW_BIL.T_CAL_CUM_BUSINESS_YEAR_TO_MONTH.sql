CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_cal_cum_business_year_to_month (
cy_month BIGNUMERIC(38,0) NOT NULL,
incl_cy_month BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);