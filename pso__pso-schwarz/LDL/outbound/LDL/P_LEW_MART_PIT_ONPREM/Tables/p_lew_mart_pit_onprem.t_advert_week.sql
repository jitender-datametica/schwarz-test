CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_week (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
adv_week_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_seq BIGNUMERIC(38,0),
adv_week_descr STRING(16777216) COLLATE 'und:ci',
adv_week_long_descr STRING(16777216) COLLATE 'und:ci',
adv_week_year_num BIGNUMERIC(38,0) DEFAULT 8888 NOT NULL,
adv_week_week_num BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
adv_week_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
adv_week_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
dwh_updated DATETIME,
PRIMARY KEY (client_id, adv_week_id, adv_week_sid) NOT ENFORCED
);