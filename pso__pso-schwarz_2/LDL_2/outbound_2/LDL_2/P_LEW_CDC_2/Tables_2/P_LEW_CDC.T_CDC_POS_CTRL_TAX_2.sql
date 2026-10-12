CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_ctrl_tax_2 (
client_id INTEGER,
loc_sid INTEGER,
register_id INTEGER,
receipt_id INTEGER,
receiptline_nr INTEGER,
receipt_dt DATE,
dwh_cal_dt DATE,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);