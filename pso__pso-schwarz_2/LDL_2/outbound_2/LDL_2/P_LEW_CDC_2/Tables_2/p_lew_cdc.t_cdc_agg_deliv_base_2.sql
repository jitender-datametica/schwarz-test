CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_deliv_base_2 (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
loc_sid_store INTEGER NOT NULL,
deliverytype_id INTEGER NOT NULL,
log_operation STRING COLLATE 'und:ci',
log_ts DATETIME
);