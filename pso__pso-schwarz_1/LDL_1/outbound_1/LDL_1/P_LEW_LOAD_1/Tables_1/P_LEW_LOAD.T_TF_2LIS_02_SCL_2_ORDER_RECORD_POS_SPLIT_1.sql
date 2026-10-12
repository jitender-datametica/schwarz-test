CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_2lis_02_scl_2_order_record_pos_split_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lis_02_scl_ebeln STRING(20),
lis_02_scl_ebelp INTEGER,
lis_02_scl_etenr INTEGER,
order_record_id NUMERIC(20,0),
order_record_pos_id BIGNUMERIC(38),
order_record_pos_split_id BIGNUMERIC(38),
order_split_qty NUMERIC(18,5),
delivery_dt DATE,
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);