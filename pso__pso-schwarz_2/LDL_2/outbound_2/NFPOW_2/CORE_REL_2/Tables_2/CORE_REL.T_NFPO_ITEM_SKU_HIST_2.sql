/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_sku_hist_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_sku_hist_2 (
nfpo_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO STOCK KEEPING UNIT.            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_SID'),
nfpo_item_sku_weight_kg_meas BIGNUMERIC(38,5)
OPTIONS(description='Defined weight in kilogramm for the stock keeping unit.            CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_WEIGHT_KG_MEAS'),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DELETED_FG'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Beginning of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.DWH_VALID_FROM'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_VALID_TO'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sku_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='NFPO item_2 sales_2 variants defined by styles, sizes and LSVs.             CBX: LDL_ITEM_ARTICLE_EAN_2, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2             LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST_2');