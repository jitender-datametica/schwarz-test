CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_payment_ntr_extract_2 (
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
pos_terminal_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
time_receipt_ejr TIME NOT NULL,
orig_receipt_nr_ejr BIGNUMERIC(38,0) NOT NULL,
orig_receipt_serial_nr_ejr BIGNUMERIC(38,0) NOT NULL,
timezone_cd BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
checker_id BIGNUMERIC(38,0) NOT NULL,
transactiontype_id STRING(3) COLLATE 'und:ci',
cnt_payment_ejr NUMERIC(18,4),
val_retail_payment_ejr NUMERIC(18,4),
tendertype_cd_ejr STRING(2) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY st_loc_sid;