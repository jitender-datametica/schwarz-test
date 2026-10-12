CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_hierarchy_2_mdm_hierarchy_node_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
hier_node_sid BIGNUMERIC(38),
src_hierarchy_cd STRING(20),
src_hier_node_path STRING(100),
hier_node_cd STRING(20),
hier_node_name STRING(100),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);