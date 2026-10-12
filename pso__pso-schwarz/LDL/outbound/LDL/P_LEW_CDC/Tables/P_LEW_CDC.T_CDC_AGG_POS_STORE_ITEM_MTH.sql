CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_pos_store_item_mth (
client_id INTEGER,
loc_sid_store INTEGER,
item_sid INTEGER,
cy_month INTEGER,
discount_sid INTEGER,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);