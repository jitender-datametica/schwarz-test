CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_adv_l_0_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size STRING(5) COLLATE 'und:ci' NOT NULL,
case_size_dec NUMERIC(9,4),
week_adv STRING(15) COLLATE 'und:ci' NOT NULL,
dat_adv DATE NOT NULL,
repeat_fg BIGNUMERIC(38),
price_retail_adv NUMERIC(18,4),
dat_notification1 DATE NOT NULL,
dat_notification2 DATE,
dat_notificationx DATE,
price_retail_adv_net NUMERIC(18,4),
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL
);