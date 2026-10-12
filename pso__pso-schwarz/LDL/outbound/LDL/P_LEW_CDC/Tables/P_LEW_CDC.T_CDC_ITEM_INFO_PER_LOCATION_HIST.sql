CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_item_info_per_location_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);