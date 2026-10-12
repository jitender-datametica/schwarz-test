CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_packing_list_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_pack_list_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO packing list
            CBX: CNT_ITEM_1,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item_1 instance reference
            CBX: CNT_ITEM.REF_NO'''),
src_pack_method_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO packing method code
            CBX: LDL_ITEM_PACKING_METHOD.LDL_CODE'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_pack_list_sid) NOT ENFORCED
)
OPTIONS(description='''information about packing lists for the sort boxes of NFPO items
             CBX: LDL_ITEM_PACKING_METHOD_1''');