CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_cal_day_py_business_year_adjusted_2 (
cal_dt DATE NOT NULL,
bus_year_diff BIGNUMERIC(38,0) NOT NULL,
incl_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY bus_year_diff;