CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_item_receipt_rel_2 (
client_id BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
dat_formdate DATE,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
barcode STRING(50) COLLATE 'und:ci',
barcode_short STRING(50) COLLATE 'und:ci',
link_type STRING(14) COLLATE 'und:ci',
cnt_item_void BIGNUMERIC(38,0),
val_retail_ejr NUMERIC(18,4)
);