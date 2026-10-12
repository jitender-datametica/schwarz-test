CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_2lis_02_scl_2_order_record (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lis_02_scl_ebeln STRING(20),
order_record_id NUMERIC(20,0),
src_lifnr STRING(40),
src_werks STRING(40),
order_type_cd STRING(20),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);