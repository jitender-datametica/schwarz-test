CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_inv_store_opendocs_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
inv_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
dat_dayend DATE,
sfotype_id BIGNUMERIC(38,0),
orig_receipt_nr_opendocs STRING(20) COLLATE 'und:ci',
val_debit_opendocs NUMERIC(18,4),
val_debit_opendocs_net NUMERIC(19,5),
val_credit_opendocs NUMERIC(18,4),
val_credit_opendocs_net NUMERIC(19,5),
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;