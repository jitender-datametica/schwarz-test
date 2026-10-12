CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemfamilygroup_2_item_familygroup_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemfamilygroup_cbxitem_itemfamilygroup_code STRING(250),
src_familygrp_cd STRING(40),
dummy_no_lookup STRING(40),
sub_item_grp_cd STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);