CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_tax_list_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
register_id BIGNUMERIC(38,0) NOT NULL,
cashier_id BIGNUMERIC(38,0),
cashier_status_id BIGNUMERIC(38,0),
audit_nr BIGNUMERIC(38,0),
tax_class_cd STRING(20),
tax_class_char_cd STRING(20),
tax_class_rate NUMERIC(18,5),
tax_val NUMERIC(18,5),
tax_total_val NUMERIC(18,5),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;