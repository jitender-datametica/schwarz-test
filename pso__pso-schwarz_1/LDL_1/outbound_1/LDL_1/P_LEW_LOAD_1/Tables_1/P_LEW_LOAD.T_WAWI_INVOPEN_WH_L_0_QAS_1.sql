CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_invopen_wh_l_0_qas_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
inv_id BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0),
sfotype_id BIGNUMERIC(38,0),
sfotype_desc STRING(40) COLLATE 'und:ci',
dat_formdate DATE NOT NULL,
val_debit_opendocs NUMERIC(18,4),
val_debit_opendocs_net NUMERIC(18,4),
val_credit_opendocs NUMERIC(18,4),
val_credit_opendocs_net NUMERIC(18,4),
orig_receipt_nr_opendocs STRING(20) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38,0) NOT NULL,
dc_server_id BIGNUMERIC(38,0) NOT NULL,
extraction_ts DATETIME
);