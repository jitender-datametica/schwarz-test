CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_hierarchy_2_mdm_hierarchy_node_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_hierarchy_cbxitem_hierarchynode_hierarchy_code STRING(250),
cbx_item_hierarchy_cbxitem_hierarchynode_path STRING(250),
src_hierarchy_cd STRING(40),
src_hier_node_path STRING(200),
src_hier_node_path_parent STRING(200),
hier_node_level BIGNUMERIC(38),
hier_node_root_fg BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);