CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_ctrl_register_transaction_2 (
client_id INTEGER,
loc_sid INTEGER,
receipt_id INTEGER,
register_id INTEGER,
transaction_type_detail_id INTEGER,
dwh_cal_dt DATE,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);