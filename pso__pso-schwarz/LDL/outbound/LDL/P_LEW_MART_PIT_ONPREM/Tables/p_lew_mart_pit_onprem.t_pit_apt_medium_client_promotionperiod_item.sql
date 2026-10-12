CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_apt_medium_client_promotionperiod_item (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
item_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_period_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
promotion_start_dt DATE DEFAULT DATE '1900-01-01' NOT NULL,
promotion_end_dt DATE DEFAULT DATE '9999-12-31' NOT NULL,
advert_medium_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
anl_advert_medium_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_medium STRING(16777216) COLLATE 'und:ci',
advert_medium_group_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_medium_group STRING(16777216) COLLATE 'und:ci',
advert_medium_ignore_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
advert_medium_delete_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
medium_deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
PRIMARY KEY (client_id, adv_week_id, item_sid, adv_period_id, advert_medium_sid) NOT ENFORCED
);