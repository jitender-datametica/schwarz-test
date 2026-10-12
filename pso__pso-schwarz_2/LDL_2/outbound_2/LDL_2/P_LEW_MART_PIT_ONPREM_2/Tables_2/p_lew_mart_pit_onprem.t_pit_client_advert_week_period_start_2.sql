CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_client_advert_week_period_start_2 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_period_start_dt DATE DEFAULT DATE '1900-01-01' NOT NULL,
adv_week_period_end_dt DATE DEFAULT DATE '9999-12-31' NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
PRIMARY KEY (client_id, adv_week_period_start_dt) NOT ENFORCED
);