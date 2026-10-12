CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_matgrp_strct_2_itemgroup_international_descr_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_matgrp_strct_hier_id STRING(4),
z_ds_wrf_matgrp_strct_node STRING(36),
z_ds_wrf_matgrp_strct_spras STRING(4),
src_node STRING(40),
lang_cd STRING(20),
item_grp_int_descr STRING(100) COLLATE 'und:ci',
item_grp_int_descr_long STRING(100) COLLATE 'und:ci',
item_grp_int_descr_caps STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);