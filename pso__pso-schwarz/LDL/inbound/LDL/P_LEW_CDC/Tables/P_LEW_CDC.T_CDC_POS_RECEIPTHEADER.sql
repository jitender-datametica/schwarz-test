CREATE TABLE P_LEW_CDC.T_CDC_POS_RECEIPTHEADER
(
client_id INTEGER,
loc_sid INTEGER,
register_id INTEGER,
receipt_id INTEGER,
dwh_cal_dt DATE,
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));