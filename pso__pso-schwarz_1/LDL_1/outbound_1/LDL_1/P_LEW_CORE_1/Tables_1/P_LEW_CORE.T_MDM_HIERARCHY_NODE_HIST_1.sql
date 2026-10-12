CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_hierarchy_node_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
hier_node_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK Node            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE'),
hier_node_sid_parent BIGNUMERIC(38,0)
OPTIONS(description='FK Node            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE'),
hier_node_level BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Node level            CBX: CNT_ITEM.HIERARCHY_HCL_LEVEL'),
hier_node_root_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Indicates that this is the root node            CBX: CNT_ITEM.HIERARCHY_HCL_LEVEL'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (hier_node_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='NFPO product hierarchy_1             CBX: derived from CNT_ITEM_1');