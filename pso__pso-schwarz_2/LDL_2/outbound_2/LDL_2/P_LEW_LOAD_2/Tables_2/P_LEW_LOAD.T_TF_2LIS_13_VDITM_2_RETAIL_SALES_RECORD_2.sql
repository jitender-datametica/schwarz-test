CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_2lis_13_vditm_2_retail_sales_record_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lis_13_vditm_vbeln STRING(20),
retail_sales_record_id NUMERIC(20,0),
src_waers STRING(40),
curr_cd STRING(20),
invoice_class_cd STRING(20),
invoice_type_cd STRING(20),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);