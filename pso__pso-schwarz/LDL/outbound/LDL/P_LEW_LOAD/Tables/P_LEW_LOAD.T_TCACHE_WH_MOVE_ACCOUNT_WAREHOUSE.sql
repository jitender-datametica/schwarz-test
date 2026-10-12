CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_wh_move_account_warehouse (
context_load_id BIGNUMERIC(38) NOT NULL,
context_country STRING(20) NOT NULL,
src_record_id BIGNUMERIC(38) NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
loc_sid_wh BIGNUMERIC(38) NOT NULL,
receipt_id STRING(100) NOT NULL,
receipt_type_id BIGNUMERIC(38) NOT NULL,
receipt_type_descr STRING(100),
account_balance_page_nr BIGNUMERIC(38),
loc_sid_store BIGNUMERIC(38),
debit_val NUMERIC(18,5),
credit_val NUMERIC(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);