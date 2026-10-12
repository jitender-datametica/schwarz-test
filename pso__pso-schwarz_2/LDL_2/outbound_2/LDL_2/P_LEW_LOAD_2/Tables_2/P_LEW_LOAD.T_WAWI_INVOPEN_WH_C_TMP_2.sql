CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_invopen_wh_c_tmp_2 (
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
inv_id BIGNUMERIC(38),
orig_store_nr BIGNUMERIC(38),
sfotype_id BIGNUMERIC(38),
sfotype_desc STRING(40) COLLATE 'und:ci',
dat_formdate DATE,
val_debit_opendocs FLOAT64,
val_credit_opendocs FLOAT64,
orig_receipt_nr_opendocs STRING(20) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38)
);