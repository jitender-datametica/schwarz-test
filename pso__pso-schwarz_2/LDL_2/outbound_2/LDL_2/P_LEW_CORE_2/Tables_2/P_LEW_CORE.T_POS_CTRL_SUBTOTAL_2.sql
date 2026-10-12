CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_subtotal_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
receipt_id BIGNUMERIC(38,0) NOT NULL,
receipt_dt DATE NOT NULL,
receipt_tmsp DATETIME NOT NULL,
register_id BIGNUMERIC(38,0) NOT NULL,
receiptline_nr BIGNUMERIC(38,0) NOT NULL,
cashier_id BIGNUMERIC(38,0),
authority_cd STRING(20) COLLATE 'und:ci',
timezone_id BIGNUMERIC(38,0),
transaction_begin_tmsp DATETIME,
transaction_type_cd STRING(20),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;