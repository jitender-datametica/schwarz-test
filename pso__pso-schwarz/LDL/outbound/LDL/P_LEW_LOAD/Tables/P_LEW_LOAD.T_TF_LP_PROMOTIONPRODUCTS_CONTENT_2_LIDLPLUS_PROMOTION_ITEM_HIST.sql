CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_promotionproducts_content_2_lidlplus_promotion_item_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lp_promotionstores_content_external_id STRING(100),
lp_promotionstores_content_product_id STRING(20) COLLATE 'und:ci',
src_external_id STRING(100),
item_sid_lp BIGNUMERIC(38),
validity_start_tmsp DATETIME,
validity_end_tmsp DATETIME,
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);