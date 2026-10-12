CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_week_period (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
adv_period_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_period_start_dt DATE DEFAULT DATE '1900-01-01' NOT NULL,
adv_week_period_end_dt DATE DEFAULT DATE '9999-12-31' NOT NULL,
adv_week_period_sort_val BIGNUMERIC(38,0) DEFAULT 99 NOT NULL
);