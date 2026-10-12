CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_delete_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
status_item_delete BIGNUMERIC(38,0),
dat_item_delete DATE,
item_closed_fg BIGNUMERIC(38,0),
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);