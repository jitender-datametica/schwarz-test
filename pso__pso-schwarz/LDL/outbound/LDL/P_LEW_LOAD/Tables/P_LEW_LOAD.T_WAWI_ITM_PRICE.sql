CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_price (
client_id BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
pricegroup_id INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
vat_id BIGNUMERIC(38) NOT NULL,
tare_cd BIGNUMERIC(38),
price_retail NUMERIC(18,4),
price_retail_net NUMERIC(19,5),
val_refund NUMERIC(18,4),
val_net_refund NUMERIC(19,5),
val_beverage_tax NUMERIC(18,4),
load_id BIGNUMERIC(38) NOT NULL
);