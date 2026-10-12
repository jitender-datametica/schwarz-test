CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_file_content_2_lil_file_content (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
lil_file_content_file_id INTEGER NOT NULL,
lil_file_content_src_region_cd STRING(20) NOT NULL,
lil_file_content_src_period_cd STRING(20) NOT NULL,
lil_file_content_src_assort_parent_cat_cd STRING(100) NOT NULL,
file_id BIGNUMERIC(38) NOT NULL,
src_region_cd STRING(40) NOT NULL,
src_period_cd STRING(40) NOT NULL,
src_assort_parent_cat_cd STRING(100) COLLATE 'und:ci' NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);