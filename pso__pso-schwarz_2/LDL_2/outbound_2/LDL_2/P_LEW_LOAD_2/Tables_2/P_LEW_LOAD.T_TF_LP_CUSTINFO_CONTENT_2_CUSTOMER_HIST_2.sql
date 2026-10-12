CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_custinfo_content_2_customer_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_custinfo_content_registration_country_cd STRING(250),
lp_custinfo_content_home_country_cd STRING(250),
lp_custinfo_content_customer_id STRING(250),
src_customerid STRING(40),
lidlplus_registration_dt DATE,
lidlplus_unregistration_dt DATE,
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);