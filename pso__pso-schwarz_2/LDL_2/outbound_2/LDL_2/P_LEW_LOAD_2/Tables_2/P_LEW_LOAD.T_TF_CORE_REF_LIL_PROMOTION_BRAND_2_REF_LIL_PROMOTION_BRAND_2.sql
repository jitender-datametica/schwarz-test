CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_ref_lil_promotion_brand_2_ref_lil_promotion_brand_2 (
promotion_brand_id BIGNUMERIC(38) NOT NULL,
promotion_brand_cd STRING(100) NOT NULL,
promotion_brand_descr STRING(100) COLLATE 'und:ci',
promotion_brand_short_descr STRING(100) COLLATE 'und:ci',
promotion_brand_level BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);