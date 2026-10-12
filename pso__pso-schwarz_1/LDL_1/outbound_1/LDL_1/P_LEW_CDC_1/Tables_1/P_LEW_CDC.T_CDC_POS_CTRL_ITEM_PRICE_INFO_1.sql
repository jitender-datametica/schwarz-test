CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_ctrl_item_price_info_1 (
client_id INTEGER,
loc_sid INTEGER,
item_sid INTEGER,
dwh_cal_dt DATE,
register_id INTEGER,
receipt_id INTEGER,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);