CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_gfk_category_descr_2_lil_gfk_category_descr (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_gfk_category_descr_src_gfk_cat_cd STRING(250) NOT NULL,
core_lil_gfk_category_descr_lang_cd STRING(250) NOT NULL,
src_gfk_cat_cd STRING(200) NOT NULL,
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL,
gfk_cat_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);