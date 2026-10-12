CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_cal_cum_year_to_partial_week_2 (
cy_week_part BIGNUMERIC(38,0) NOT NULL,
incl_cy_week_part BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);