CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_day_sales_payment_type_1 (
client_id INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
cy_month INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
orig_store_nr INTEGER,
currency_iso_cd STRING(20) NOT NULL,
sales_net_val_pos NUMERIC(18,5),
return_net_val_pos NUMERIC(18,5),
cnt_customer INTEGER,
sales_payment_type INTEGER NOT NULL
);