CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_custinfo_content_2_customer_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_custinfo_content_customer_id STRING(250),
src_customerid STRING(20),
lidlplus_customer_cd STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);