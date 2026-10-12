CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_sales_quantity_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_ian INTEGER NOT NULL,
item_sid BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
adv_store_dt DATE NOT NULL,
adv_ian_dt DATE NOT NULL,
range_plan_cd STRING(20) COLLATE 'und:ci',
ean_barcode_clean BIGNUMERIC(38,0),
sales_hour BIGNUMERIC(38,0),
sales_dt DATE,
sales_qty NUMERIC(18,4)
);