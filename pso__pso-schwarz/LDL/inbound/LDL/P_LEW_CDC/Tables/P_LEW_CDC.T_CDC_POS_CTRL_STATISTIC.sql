CREATE TABLE P_LEW_CDC.T_CDC_POS_CTRL_STATISTIC
(
client_id INTEGER,
loc_sid INTEGER,
cashier_id INTEGER,
register_id INTEGER,
statistic_id INTEGER,
dwh_cal_dt DATE,
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));


