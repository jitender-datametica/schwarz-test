/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_style_hist_2
   generated from Powerdesigner on Dienstag, 25. November 2025 15:36:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_style_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
mdm_item_style_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item_2 style
            CBX: CNT_ITEM_2,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID'''),
style_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''item_2 style code, usually IAN + suffix
            CBX: LDL_ITEM_STYLE.LDL_ITEM_STYLE_NO'''),
style_name STRING(300) COLLATE 'und:ci'
OPTIONS(description='''name of the item_2 style
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME'''),
style_descr STRING(4000) COLLATE 'und:ci'
OPTIONS(description='''item_2 style description
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_DESC'''),
color_descr STRING(4000)
OPTIONS(description='''Item_2 style color description. Non-standard textual entries referring to color descriptions.
            CBX: LDL_ITEM_STYLE.LDL_FARBE'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_style_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='''NFPO item_2 variant defining styles.
             CBX: LDL_ITEM_STYLE''');