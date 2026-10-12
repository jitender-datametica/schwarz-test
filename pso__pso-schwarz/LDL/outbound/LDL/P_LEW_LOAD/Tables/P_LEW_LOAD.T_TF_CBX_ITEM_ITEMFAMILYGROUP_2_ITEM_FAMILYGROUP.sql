CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemfamilygroup_2_item_familygroup (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemfamilygroup_cbxitem_itemfamilygroup_code STRING(250),
src_familygrp_cd STRING(20),
src_node STRING(20),
src_familygrp_id BIGNUMERIC(38),
item_fam_grp_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);