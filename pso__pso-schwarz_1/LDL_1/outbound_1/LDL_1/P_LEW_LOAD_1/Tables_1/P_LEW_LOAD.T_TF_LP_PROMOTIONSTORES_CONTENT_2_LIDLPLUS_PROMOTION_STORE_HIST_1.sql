CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_promotionstores_content_2_lidlplus_promotion_store_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_promotionstores_content_external_id STRING(100),
lp_promotionstores_content_store_id BIGNUMERIC(38),
src_external_id STRING(100),
src_orig_store_nr BIGNUMERIC(38),
validity_start_tmsp DATETIME,
validity_end_tmsp DATETIME,
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);