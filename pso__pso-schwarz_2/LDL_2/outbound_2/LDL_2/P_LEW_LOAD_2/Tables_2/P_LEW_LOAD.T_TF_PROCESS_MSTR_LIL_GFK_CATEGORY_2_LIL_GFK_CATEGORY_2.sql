CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_gfk_category_2_lil_gfk_category_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
process_mstr_lil_gfk_category_src_gfk_cat_cd STRING(250) NOT NULL,
src_gfk_cat_cd STRING(200) NOT NULL,
gfk_cat_id BIGNUMERIC(38) NOT NULL,
gfk_cat_name_en STRING(100) COLLATE 'und:ci' NOT NULL,
gfk_cat_name_de STRING(100) COLLATE 'und:ci' NOT NULL,
gfk_cat_short_name STRING(100) COLLATE 'und:ci',
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);