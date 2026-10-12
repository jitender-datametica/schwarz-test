CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_ref_lil_promotion_brand_descr_2_ref_lil_promotion_brand_descr (
promotion_brand_id BIGNUMERIC(38) NOT NULL,
core_ref_lil_promotion_brand_descr_lang_cd STRING(250) NOT NULL,
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL,
promotion_brand_descr STRING(100) COLLATE 'und:ci' NOT NULL,
promotion_brand_short_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);