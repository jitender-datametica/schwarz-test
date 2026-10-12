CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_stc_store_item_fv_2 (
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
dat_dayend DATE,
qty_stc_fv NUMERIC(18,4),
price_retail NUMERIC(18,4),
price_retail_net NUMERIC(19,5),
val_vat NUMERIC(18,4),
price_buying NUMERIC(18,4),
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;