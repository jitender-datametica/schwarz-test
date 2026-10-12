CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_inv_item_wh_prev_dat_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
inv_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
prev_dat_formdate DATE
);