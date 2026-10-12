CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_SKU_HIST_1 (
   mdm_item_sku_sid                         COMMENT 'Foreign key NFPO stock keeping unit.
CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE'
  ,mdm_item_sku_weight_kg_meas              COMMENT 'Defined weight in kilogramm for the stock keeping unit.
CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,client_id                                COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'NFPO item_1 sales_1 variants defined by styles, sizes and LSVs.
CBX: LDL_ITEM_ARTICLE_EAN_1, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1'
AS SELECT
   mdm_item_sku_sid
  ,mdm_item_sku_weight_kg_meas
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_SKU_HIST_1
;