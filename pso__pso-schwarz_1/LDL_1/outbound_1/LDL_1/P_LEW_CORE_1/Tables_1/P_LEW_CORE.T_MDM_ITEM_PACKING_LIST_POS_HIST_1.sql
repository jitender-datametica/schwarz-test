CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_packing_list_pos_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_pack_list_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO packing list
            CBX: CNT_ITEM_1,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE'''),
mdm_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 set
            CBX: CNT_ITEM_1,
            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
mdm_item_size_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 size
            CBX: CNT_ITEM_1,
            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,
            LDL_ITEM_SIZE.LDL_CODE'''),
pack_list_pos_version BIGNUMERIC(38,0)
OPTIONS(description='''technical version of the NFPO packing list position definition in the source system
            CBX: LDL_ITEM_PACK_ASSORT_SIZE.REVISION'''),
pack_list_pos_priority BIGNUMERIC(38,0)
OPTIONS(description='''sequence number of the position in the pack list 
            CBX: LDL_ITEM_PACK_ASSORT_SIZE.INTERNAL_SEQ_NO'''),
pack_list_pos_req_qty BIGNUMERIC(38,0)
OPTIONS(description='''reqested quantity of the item_1 variant represented by the position in the pack list 
            CBX: LDL_ITEM_PACK_ASSORT_SIZE.LDL_QUANTITY'''),
pack_list_pos_pack_qty BIGNUMERIC(38,0)
OPTIONS(description='''calculated packed quantity of the item_1 variant represented by the position in the pack list 
            CBX: LDL_ITEM_PACKING_METHOD_1,
            LDL_ITEM_PACK_ASSORT_SIZE,.LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO,
            LDL_ITEM_PACK_ASSORT_SIZE.LDL_QUANTITY'''),
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
PRIMARY KEY (mdm_pack_list_sid, mdm_item_set_sid, mdm_item_size_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''detailed information about packing lists for the sort boxes of NFPO items
             CBX: LDL_ITEM_PACKING_METHOD_1''');