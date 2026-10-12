CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_day_item_store_adv_cnt (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_cal_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
adv_week_id BIGNUMERIC(38,0) NOT NULL,
f_client_store_cnt_adv INTEGER,
f_client_store_cnt_adv_week INTEGER
);