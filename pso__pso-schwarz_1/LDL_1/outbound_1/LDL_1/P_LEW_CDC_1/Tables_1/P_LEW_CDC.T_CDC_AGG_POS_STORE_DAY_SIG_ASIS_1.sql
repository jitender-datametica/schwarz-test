CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_pos_store_day_sig_asis_1 (
client_id INTEGER,
loc_sid_store INTEGER,
sub_item_grp_sid INTEGER,
dwh_cal_dt DATE,
cy_month INTEGER,
discount_sid INTEGER,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);