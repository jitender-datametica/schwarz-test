CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_size (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_size_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item size
            CBX: CNT_ITEM,
            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,
            LDL_ITEM_SIZE.LDL_CODE'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item instance reference
            CBX: CNT_ITEM.REF_NO'''),
src_size_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the NFPO item size for a certain item in the source system
            CBX: LDL_ITEM_SIZE.CBXITEM_ITEMSIZE_CODE'''),
size_name STRING(300) COLLATE 'und:ci'
OPTIONS(description='''name of the NFPO item size
            CBX: LDL_ITEM_SIZE.LDL_NAME'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_size_sid) NOT ENFORCED
) OPTIONS(description='''NFPO item variant defining sizes
             CBX: LDL_ITEM_SIZE''');