CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_hierarchy_2_mdm_hierarchy_node_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_hierarchy_cbxitem_hierarchynode_hierarchy_code STRING(250),
cbx_item_hierarchy_cbxitem_hierarchynode_path STRING(250),
src_hierarchy_cd STRING(20),
src_hier_node_path STRING(100),
hier_node_cd STRING(20),
hier_node_name STRING(100),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);