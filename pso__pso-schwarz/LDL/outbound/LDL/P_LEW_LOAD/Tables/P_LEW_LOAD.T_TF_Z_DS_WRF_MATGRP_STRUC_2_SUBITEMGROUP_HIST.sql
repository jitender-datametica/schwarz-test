CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_matgrp_struc_2_subitemgroup_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_matgrp_struc_hier_id STRING(4),
z_ds_wrf_matgrp_struc_node STRING(36),
z_ds_wrf_matgrp_struc_date_from DATE,
src_node_suig STRING(40),
src_node_igri STRING(40),
item_grp_int_cd STRING(20),
main_item_grp_cd STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);