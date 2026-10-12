CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_sql_sales_cond_denorm_2_item_location_stock_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
item_sid BIGNUMERIC(38) NOT NULL,
loc_sid BIGNUMERIC(38) NOT NULL,
src_space_switch BIGNUMERIC(38) NOT NULL,
price NUMERIC(18,5),
price_net NUMERIC(18,5),
calc_qty NUMERIC(18,5),
inv_qty NUMERIC(18,5),
diff_qty_inv_calc NUMERIC(18,5),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);