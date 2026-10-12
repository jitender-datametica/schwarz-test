CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_ref_lil_promotion_brand_2_ref_lil_promotion_brand_1 (
promotion_brand_id BIGNUMERIC(38) NOT NULL,
promotion_brand_descr STRING(100) COLLATE 'und:ci',
liam1_srt_cd BIGNUMERIC(38),
lift1_srt_cd BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);