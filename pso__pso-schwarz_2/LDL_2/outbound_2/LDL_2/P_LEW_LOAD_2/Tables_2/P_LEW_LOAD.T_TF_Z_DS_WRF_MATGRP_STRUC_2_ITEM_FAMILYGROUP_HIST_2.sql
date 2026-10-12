CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_matgrp_struc_2_item_familygroup_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_matgrp_struc_hier_id STRING(4),
z_ds_wrf_matgrp_struc_node STRING(36),
z_ds_wrf_matgrp_struc_date_from DATE,
src_node_famg STRING(40),
src_node_suig STRING(40),
sub_item_grp_cd STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);