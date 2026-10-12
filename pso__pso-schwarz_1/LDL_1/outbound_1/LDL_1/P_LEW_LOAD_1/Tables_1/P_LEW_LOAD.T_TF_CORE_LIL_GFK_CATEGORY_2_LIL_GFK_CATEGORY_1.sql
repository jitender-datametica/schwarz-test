CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_gfk_category_2_lil_gfk_category_1 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_gfk_category_src_gfk_cat_cd STRING(250) NOT NULL,
src_gfk_cat_cd STRING(100) NOT NULL,
gfk_cat_name STRING(100) COLLATE 'und:ci' NOT NULL,
gfk_cat_level BIGNUMERIC(38) NOT NULL,
gfk_cat_type_cd STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);