CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_inventory_stock_1 (
client_id INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
inv_status_id INTEGER,
inv_stock_qty NUMERIC(18,5),
calc_stock_qty NUMERIC(18,5),
inv_calc_stock_diff NUMERIC(18,5),
retail_price NUMERIC(18,5),
retail_net_price NUMERIC(18,5),
retail_price_diff NUMERIC(18,5),
retail_net_price_diff NUMERIC(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);