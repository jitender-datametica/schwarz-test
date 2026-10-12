CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_retailer_2_lil_retailer_1 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
lil_retailer_src_retailer_cd STRING(250) NOT NULL,
src_retailer_cd STRING(100) NOT NULL,
retailer_name STRING(100) COLLATE 'und:ci' NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);