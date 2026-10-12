CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_day_miss_item_wh_act (
dat_sys DATE NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
wh_id_pp BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
orig_item_nr_pp BIGNUMERIC(38) NOT NULL
);