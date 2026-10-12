CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_adv_item_advertising_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_adv DATE NOT NULL,
dat_dayend DATE,
week_adv STRING(15) COLLATE 'und:ci' NOT NULL,
dat_notification1 DATE NOT NULL,
dat_notification2 DATE,
dat_notificationx DATE,
repeat_fg BIGNUMERIC(38,0),
price_retail_adv NUMERIC(18,4),
price_retail_net_adv NUMERIC(19,5),
case_size_dec NUMERIC(9,4),
load_id BIGNUMERIC(38,0) NOT NULL
);