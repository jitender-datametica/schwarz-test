CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_style_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_style_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item_1 style
            CBX: CNT_ITEM_1,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item_1 instance reference
            CBX: CNT_ITEM.REF_NO'''),
src_style_uniq_id STRING(200) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the item_1 style in the source system
            CBX: LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID'''),
style_name STRING(300) COLLATE 'und:ci'
OPTIONS(description='''name of the item_1 style
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_style_sid) NOT ENFORCED
) OPTIONS(description='''NFPO item_1 variant defining styles
             CBX: LDL_ITEM_STYLE''');