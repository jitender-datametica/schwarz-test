CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_ctrl_statistic_1 (
client_id INTEGER,
loc_sid INTEGER,
cashier_id INTEGER,
register_id INTEGER,
statistic_id INTEGER,
dwh_cal_dt DATE,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);