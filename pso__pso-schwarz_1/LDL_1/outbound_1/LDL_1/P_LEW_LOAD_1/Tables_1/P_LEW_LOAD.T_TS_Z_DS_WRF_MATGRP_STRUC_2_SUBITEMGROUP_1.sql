CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_wrf_matgrp_struc_2_subitemgroup_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
sub_item_grp_sid BIGNUMERIC(38),
src_node STRING(20),
src_subitemgrp_cd STRING(20),
src_subitemgrp_id BIGNUMERIC(38),
sub_item_grp_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);