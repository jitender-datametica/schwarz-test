CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_cal_cum_year_to_date_1 (
cal_dt DATE NOT NULL,
incl_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);