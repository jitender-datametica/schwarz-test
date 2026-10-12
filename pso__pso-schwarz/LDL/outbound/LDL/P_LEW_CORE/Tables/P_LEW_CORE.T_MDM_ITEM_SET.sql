CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_set (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item set
            CBX: CNT_ITEM,
            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item instance reference
            CBX: CNT_ITEM.REF_NO'''),
src_style_uniqids_cd STRING(2000) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the style composition in the source system
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
set_content_qty BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''total number of units in the set
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
set_multipack_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''calculated indicator whether as set is composed from more than one style
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_set_sid) NOT ENFORCED
)
OPTIONS(description='''NFPO item variant defining sets of styles
             CBX: LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_STYLE''');