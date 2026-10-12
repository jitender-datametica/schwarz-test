CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_pos_store_item_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
discount_sid BIGNUMERIC(38,0) NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);