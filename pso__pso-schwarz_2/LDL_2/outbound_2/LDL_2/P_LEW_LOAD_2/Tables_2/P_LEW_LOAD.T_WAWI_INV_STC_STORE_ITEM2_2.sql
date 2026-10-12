CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_inv_stc_store_item2_2 (
store_id BIGNUMERIC(38) NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
dat_formdate DATE NOT NULL,
qty_inv_stc_calc NUMERIC(18,4),
qty_inv_stc_cnt NUMERIC(18,4),
diff_inv_stc_calc_cnt NUMERIC(18,4),
status_inv_stc BIGNUMERIC(38),
price_retail NUMERIC(18,4),
price_retail_net NUMERIC(19,5),
price_diff NUMERIC(18,4),
price_net_diff NUMERIC(19,5),
load_id BIGNUMERIC(38) NOT NULL
);