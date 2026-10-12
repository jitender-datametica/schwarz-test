CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_tax_extract (
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
transactiontype_id STRING(3) COLLATE 'und:ci' NOT NULL,
val_vat_base_ejr NUMERIC(18,4) NOT NULL,
val_vat_ejr NUMERIC(18,4) NOT NULL,
pct_vat_ejr NUMERIC(9,4) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY st_loc_sid;