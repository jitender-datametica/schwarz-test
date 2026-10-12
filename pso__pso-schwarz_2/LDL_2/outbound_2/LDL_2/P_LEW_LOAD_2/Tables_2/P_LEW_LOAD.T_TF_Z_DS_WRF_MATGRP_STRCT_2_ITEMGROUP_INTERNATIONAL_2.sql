CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_matgrp_strct_2_itemgroup_international_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_matgrp_strct_hier_id STRING(4),
z_ds_wrf_matgrp_strct_node STRING(36),
src_node STRING(20),
src_itemgrp_int_cd STRING(20),
src_itemgrp_int_id BIGNUMERIC(38),
item_grp_int_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);