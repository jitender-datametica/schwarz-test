CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_mmo_item_location_replenishment_info_hist_1 (
client_id BIGNUMERIC(38),
loc_sid BIGNUMERIC(38) NOT NULL,
item_sid BIGNUMERIC(38) NOT NULL,
loc_sid_wh BIGNUMERIC(38),
max_stock_unit_id BIGNUMERIC(38),
max_stock_qty NUMERIC(18,5),
orientation_stock_unit_id BIGNUMERIC(38),
orientation_stock_qty NUMERIC(18,5),
order_stock_unit_id BIGNUMERIC(38),
order_stock_qty NUMERIC(18,5),
min_order_unit_id BIGNUMERIC(38),
min_order_qty NUMERIC(18,5),
extraction_date DATE NOT NULL,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);