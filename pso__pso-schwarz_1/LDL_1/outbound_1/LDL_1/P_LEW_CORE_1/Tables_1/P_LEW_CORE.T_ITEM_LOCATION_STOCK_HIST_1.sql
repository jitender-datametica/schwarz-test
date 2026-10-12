CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_location_stock_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
src_space_switch BIGNUMERIC(38,0) NOT NULL,
price NUMERIC(18,5),
price_net NUMERIC(18,5),
calc_qty NUMERIC(18,5) NOT NULL,
inv_qty NUMERIC(18,5) NOT NULL,
diff_qty_inv_calc NUMERIC(18,5) NOT NULL,
store_storage_qty BIGNUMERIC(38,5),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_last_confirm_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_valid_from, dwh_valid_to;