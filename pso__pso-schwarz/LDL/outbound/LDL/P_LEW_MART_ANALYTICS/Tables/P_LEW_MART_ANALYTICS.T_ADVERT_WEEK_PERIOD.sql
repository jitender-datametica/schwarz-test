CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_week_period (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_week_id BIGNUMERIC(38,0) NOT NULL,
adv_period_id BIGNUMERIC(38,0) NOT NULL,
adv_week_period_start_dt DATE NOT NULL,
adv_week_period_end_dt DATE NOT NULL,
adv_week_period_sort_val BIGNUMERIC(38,0) NOT NULL
);