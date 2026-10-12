CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_ctrl_subtotal (
client_id INTEGER,
loc_sid INTEGER,
receiptline_nr INTEGER,
register_id INTEGER,
receipt_id INTEGER,
dwh_cal_dt DATE,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);