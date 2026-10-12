CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_item_location_stock_hist_1 (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
src_space_switch INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);