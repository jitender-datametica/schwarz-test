CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_time_list_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
register_id BIGNUMERIC(38,0) NOT NULL,
cashier_id BIGNUMERIC(38,0),
cashier_status_id BIGNUMERIC(38,0),
audit_nr BIGNUMERIC(38,0),
ti_cd STRING(20) COLLATE 'und:ci',
ti_cnt NUMERIC(18,5),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;