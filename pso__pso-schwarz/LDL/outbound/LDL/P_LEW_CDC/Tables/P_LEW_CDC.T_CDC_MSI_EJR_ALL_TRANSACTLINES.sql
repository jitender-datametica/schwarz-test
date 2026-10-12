CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_msi_ejr_all_transactlines (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
pos_terminal_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
time_receipt_ejr TIME NOT NULL,
orig_receipt_nr_ejr BIGNUMERIC(38,0) NOT NULL,
orig_receipt_serial_nr_ejr BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);