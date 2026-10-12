CREATE TABLE p_lew_cdc.t_cdc_mov_item_receive_wh_2
(
client_id INTEGER NOT NULL,
loc_sid_wh INTEGER,
item_sid INTEGER,
dwh_cal_dt DATE NOT NULL,
location_item_receipt_id DECIMAL(20,0) NOT NULL,
location_item_receipt_pos_id INTEGER NOT NULL,
receipt_type_id INTEGER,
stock_location_nr INTEGER,
curr_cd_from VARCHAR(20) COLLATE 'en-ci',
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));

