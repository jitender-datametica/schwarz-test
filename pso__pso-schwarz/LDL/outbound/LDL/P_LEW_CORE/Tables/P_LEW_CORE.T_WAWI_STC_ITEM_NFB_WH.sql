CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_stc_item_nfb_wh (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
pos_nr BIGNUMERIC(38,0) NOT NULL,
pos_nr_link BIGNUMERIC(38,0),
nfb_type_cd BIGNUMERIC(38,0) NOT NULL,
qty_case_nfb NUMERIC(18,4),
dat_dayend DATE,
price_retail NUMERIC(18,4),
price_retail_net NUMERIC(19,5),
val_vat NUMERIC(18,4),
price_buying NUMERIC(18,4),
dat_modification DATE,
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;