/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_hist_2
   generated from Powerdesigner on Dienstag, 25. November 2025 15:37:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_sku_hist_2 (
mdm_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Foreign key NFPO stock keeping unit.
            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE'''),
mdm_item_sku_weight_kg_meas BIGNUMERIC(38,5)
OPTIONS(description='''Defined weight in kilogramm for the stock keeping unit.
            CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''NFPO item_2 sales_2 variants defined by styles, sizes and LSVs.
             CBX: LDL_ITEM_ARTICLE_EAN_2, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2''');