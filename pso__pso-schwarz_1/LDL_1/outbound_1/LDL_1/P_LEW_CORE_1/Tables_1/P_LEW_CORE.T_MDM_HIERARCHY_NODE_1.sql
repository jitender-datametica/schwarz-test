CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_hierarchy_node_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
hier_node_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='PK Node            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE'),
src_hierarchy_cd STRING(20) NOT NULL
OPTIONS(description='Name of attached hierarchy_1            CBX: CNT_ITEM.HIERARCHY_HCL'),
src_hier_node_path STRING(100) NOT NULL OPTIONS(description='Path to node            CBX: CNT_ITEM.HIERARCHY_FULL_CODE'),
hier_node_cd STRING(20) NOT NULL OPTIONS(description='Node code            CBX: CNT_ITEM.HIERARCHY_FULL_CODE'),
hier_node_name STRING(100) OPTIONS(description='Node name            CBX: CNT_ITEM.HIERARCHY_FULL_NAME'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (hier_node_sid) NOT ENFORCED
) OPTIONS(description='NFPO product hierarchy_1             CBX: derived from CNT_ITEM_1');