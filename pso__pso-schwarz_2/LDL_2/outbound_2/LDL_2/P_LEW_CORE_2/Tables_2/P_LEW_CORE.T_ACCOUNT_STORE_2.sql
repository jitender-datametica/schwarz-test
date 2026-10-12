CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_account_store_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
receipt_id STRING(100) COLLATE 'und:ci' NOT NULL,
account_id BIGNUMERIC(38,0) NOT NULL,
receipt_type_id BIGNUMERIC(38,0) NOT NULL,
receipt_type_descr STRING(100) COLLATE 'und:ci',
acct_balance_page_nr BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
loc_sid_proc_wh BIGNUMERIC(38,0),
loc_sid_dest_wh BIGNUMERIC(38,0),
debit_val NUMERIC(18,5),
credit_val NUMERIC(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;