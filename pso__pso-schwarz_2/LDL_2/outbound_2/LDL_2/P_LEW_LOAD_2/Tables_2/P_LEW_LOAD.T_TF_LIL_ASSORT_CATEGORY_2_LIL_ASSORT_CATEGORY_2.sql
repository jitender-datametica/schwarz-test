CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_assort_category_2_lil_assort_category_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
lil_assort_category_src_assort_cat_cd STRING(250) NOT NULL,
lil_assort_category_src_assort_parent_cat_cd STRING(250) NOT NULL,
src_assort_parent_cat_cd STRING(100) NOT NULL,
src_assort_cat_cd STRING(300) NOT NULL,
assort_parent_cat_name STRING(100) COLLATE 'und:ci' NOT NULL,
assort_cat_name STRING(300) COLLATE 'und:ci' NOT NULL,
assort_cat_level BIGNUMERIC(38) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);