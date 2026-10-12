CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_wawi_itm_item_wh_day_roc (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);