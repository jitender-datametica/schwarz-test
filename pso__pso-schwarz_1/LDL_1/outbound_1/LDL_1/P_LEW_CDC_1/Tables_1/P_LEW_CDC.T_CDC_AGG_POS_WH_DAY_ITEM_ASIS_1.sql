CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_pos_wh_day_item_asis_1 (
client_id INTEGER,
loc_sid_wh INTEGER,
item_sid INTEGER,
dwh_cal_dt DATE,
discount_sid INTEGER,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);