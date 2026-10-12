CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_mov_item_receive_wh_2 (
client_id INTEGER NOT NULL,
loc_sid_wh INTEGER,
item_sid INTEGER,
dwh_cal_dt DATE NOT NULL,
location_item_receipt_id NUMERIC(20,0) NOT NULL,
location_item_receipt_pos_id INTEGER NOT NULL,
receipt_type_id INTEGER,
stock_location_nr INTEGER,
curr_cd_from STRING(20) COLLATE 'und:ci',
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);