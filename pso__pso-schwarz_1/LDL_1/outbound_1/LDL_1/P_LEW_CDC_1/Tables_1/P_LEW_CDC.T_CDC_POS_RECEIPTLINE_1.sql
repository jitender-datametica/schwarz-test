CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_pos_receiptline_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
register_id BIGNUMERIC(38,0) NOT NULL,
receipt_id BIGNUMERIC(38,0) NOT NULL,
receiptline_nr BIGNUMERIC(38,0),
dwh_cal_dt DATE NOT NULL,
turnover_relevant_fg BIGNUMERIC(38,0),
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);