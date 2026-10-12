CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_sup_wh_buying_price2_1 (
client_id BIGNUMERIC(38) NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
supplier_id BIGNUMERIC(38) NOT NULL,
dat_valid_from DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_rec_end_new DATE NOT NULL,
dat_rec_end_new2 DATE,
not_valid_end_fg BIGNUMERIC(38) NOT NULL,
load_ts DATETIME
);