CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_promotions_content_2_lidlplus_promotion_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_promotions_content_external_id STRING(100),
src_external_id STRING(100),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);