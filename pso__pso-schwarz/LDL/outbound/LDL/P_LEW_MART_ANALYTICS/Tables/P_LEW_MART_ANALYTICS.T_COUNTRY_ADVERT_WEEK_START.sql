CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_country_advert_week_start (
client_id BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
adv_week_start_day BIGNUMERIC(38,0) NOT NULL,
following_cal_week_fg BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);