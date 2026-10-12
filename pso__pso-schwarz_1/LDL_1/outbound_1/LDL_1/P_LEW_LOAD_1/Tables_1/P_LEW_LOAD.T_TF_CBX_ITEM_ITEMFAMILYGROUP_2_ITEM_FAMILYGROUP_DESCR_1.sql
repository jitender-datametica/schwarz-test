CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemfamilygroup_2_item_familygroup_descr_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemfamilygroup_cbxitem_itemfamilygroup_code STRING(250),
src_familygrp_cd STRING(40),
lang_cd STRING(20),
item_fam_grp_descr STRING(100) COLLATE 'und:ci',
item_fam_grp_descr_long STRING(100) COLLATE 'und:ci',
item_fam_grp_descr_caps STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);