/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_ean_hist_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:40:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_sku_ean_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO stock keeping unit_2
            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE'''),
cbx_ean_version_nr BIGNUMERIC(38,0)
OPTIONS(description='''technical version of the NFPO GTIN assignment to a sku in the source system
            CBX: LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.REVISION'''),
barcode STRING(20) COLLATE 'und:ci'
OPTIONS(description='''assigned GTIN of the NFPO stock keeping unit_2 for Lidl
            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.LDL_EAN'''),
kfl_barcode STRING(20)
OPTIONS(description='''assigned GTIN of the NFPO stock keeping unit_2 for Kaufland
            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL'''),
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
PRIMARY KEY (mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''NFPO item_2 sales_2 variants defined by styles, sizes and LSVs
             CBX: LDL_ITEM_ARTICLE_EAN_2, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2''');