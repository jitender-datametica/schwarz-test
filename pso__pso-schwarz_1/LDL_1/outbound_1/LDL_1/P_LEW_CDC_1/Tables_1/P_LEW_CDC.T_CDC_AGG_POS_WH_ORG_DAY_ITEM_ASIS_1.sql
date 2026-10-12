CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_pos_wh_org_day_item_asis_1 (
client_id BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
aspect_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
dwh_cal_dt DATE,
discount_sid BIGNUMERIC(38,0),
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);