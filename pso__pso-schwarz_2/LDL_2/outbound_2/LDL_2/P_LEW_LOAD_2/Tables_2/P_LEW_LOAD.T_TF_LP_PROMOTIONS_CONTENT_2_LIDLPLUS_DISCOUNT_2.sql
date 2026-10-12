CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_promotions_content_2_lidlplus_discount_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_promotions_content_discount_id BIGNUMERIC(38),
lp_promotions_content_validity_start_tmsp DATETIME,
lidlplus_discount_id BIGNUMERIC(38),
src_external_id STRING(100),
store_all_fg BIGNUMERIC(38),
promotion_type STRING(100) COLLATE 'und:ci',
benefit STRING(100) COLLATE 'und:ci',
benefit_type STRING(100) COLLATE 'und:ci',
validity_start_tmsp DATETIME,
validity_end_tmsp DATETIME,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);