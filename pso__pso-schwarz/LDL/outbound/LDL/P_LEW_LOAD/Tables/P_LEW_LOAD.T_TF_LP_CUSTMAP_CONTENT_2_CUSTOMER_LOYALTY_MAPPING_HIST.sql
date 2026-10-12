CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_custmap_content_2_customer_loyalty_mapping_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_custmap_content_customer_id STRING(250),
lp_custmap_content_loyalty_cd STRING(250) COLLATE 'und:ci',
src_customerid STRING(40),
loyalty_cd STRING(100) COLLATE 'und:ci',
ident_type_cd STRING(20) COLLATE 'und:ci',
mapping_start_tmsp DATETIME,
mapping_end_tmsp DATETIME,
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);