CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_matgrp_struc_2_item_familygroup_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_matgrp_struc_hier_id STRING(4),
z_ds_wrf_matgrp_struc_node STRING(36),
z_ds_wrf_matgrp_struc_date_from DATE,
src_node STRING(20),
src_familygrp_cd STRING(20),
src_familygrp_id BIGNUMERIC(38),
item_fam_grp_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);