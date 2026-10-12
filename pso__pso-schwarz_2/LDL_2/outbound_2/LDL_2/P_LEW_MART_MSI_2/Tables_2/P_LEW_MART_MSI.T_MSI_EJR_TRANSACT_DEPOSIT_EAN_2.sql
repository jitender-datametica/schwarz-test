CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_transact_deposit_ean_2 (
client_id BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
dat_formdate DATE,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
barcode STRING(50) COLLATE 'und:ci',
pfand_ean STRING(13) COLLATE 'und:ci',
cnt_all_deposit_ean_cnt BIGNUMERIC(38,0),
cnt_man_deposit_ean BIGNUMERIC(38,0),
cnt_all_deposit_ean BIGNUMERIC(38,0)
);