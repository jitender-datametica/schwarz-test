CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_set_composition (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item set
            CBX: CNT_ITEM,
            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
mdm_item_style_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item style
            CBX: CNT_ITEM,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID'''),
style_qty BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''number of units of the style in the set
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_set_sid, mdm_item_style_sid) NOT ENFORCED
)
OPTIONS(description='''NFPO item variant defining sets of styles relation to single styles
             CBX: LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_STYLE''');