CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_week (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_week_id BIGNUMERIC(38,0) NOT NULL,
adv_week_descr STRING(50) COLLATE 'und:ci' NOT NULL,
adv_week_year_num BIGNUMERIC(38,0) NOT NULL,
adv_week_week_num BIGNUMERIC(38,0) NOT NULL,
adv_week_start_dt DATE NOT NULL,
adv_week_end_dt DATE NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);