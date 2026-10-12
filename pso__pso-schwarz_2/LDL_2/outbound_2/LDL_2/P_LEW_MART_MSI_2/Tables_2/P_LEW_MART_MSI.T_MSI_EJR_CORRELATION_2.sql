CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_correlation_2 (
st_loc_sid BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
dat_formdate DATE,
time_receipt_ejr TIME,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
authority_id STRING(40) COLLATE 'und:ci',
scenario_id STRING(30) COLLATE 'und:ci',
auth_type STRING(40) COLLATE 'und:ci',
val_authorised_retail_ejr NUMERIC(18,4),
cnt_authorised_receipt BIGNUMERIC(38,0)
);