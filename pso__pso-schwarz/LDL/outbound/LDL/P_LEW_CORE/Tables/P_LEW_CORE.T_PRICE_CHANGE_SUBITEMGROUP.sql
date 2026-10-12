CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_change_subitemgroup (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL,
account_id BIGNUMERIC(38,0) NOT NULL,
receipt_type_id BIGNUMERIC(38,0) NOT NULL,
receipt_type_descr STRING(100) COLLATE 'und:ci',
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
price_change_debit_val NUMERIC(18,5),
price_change_debit_net_val NUMERIC(18,5),
price_changel_credit_val NUMERIC(18,5),
price_change_credit_net_val NUMERIC(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;