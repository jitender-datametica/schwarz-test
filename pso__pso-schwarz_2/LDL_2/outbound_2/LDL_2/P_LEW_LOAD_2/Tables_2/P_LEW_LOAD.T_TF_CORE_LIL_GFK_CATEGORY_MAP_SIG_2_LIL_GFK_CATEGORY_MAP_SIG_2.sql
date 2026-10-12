CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_gfk_category_map_sig_2_lil_gfk_category_map_sig_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_gfk_category_map_sig_src_gfk_cat_cd STRING(250) NOT NULL,
core_lil_gfk_category_map_sig_src_subitemgrp_cd STRING(250) NOT NULL,
src_gfk_cat_cd STRING(200) NOT NULL,
src_subitemgrp_cd STRING(40) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);