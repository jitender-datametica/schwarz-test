CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_agg_store_day_item_adv_asis_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_adv DATE NOT NULL,
dat_formdate DATE NOT NULL,
qty_sales NUMERIC(18,4),
qty_piece_ejr NUMERIC(18,4),
qty_weight_ejr NUMERIC(18,4),
qty_return_ejr NUMERIC(18,4),
qty_delivery NUMERIC(18,4),
qty_stc_real NUMERIC(18,4),
timestamp_mod DATETIME NOT NULL
) CLUSTER BY dat_adv;