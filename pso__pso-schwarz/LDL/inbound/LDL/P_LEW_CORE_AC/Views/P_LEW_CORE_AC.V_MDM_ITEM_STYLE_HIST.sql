CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_STYLE_HIST (
   client_id                                COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.'
  ,mdm_item_style_sid                       COMMENT 'surrogate key NFPO item style
CBX: CNT_ITEM,
LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID'
  ,style_cd                                 COMMENT 'item style code, usually IAN + suffix
CBX: LDL_ITEM_STYLE.LDL_ITEM_STYLE_NO'
  ,style_name                               COMMENT 'name of the item style
CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME'
  ,style_descr                              COMMENT 'item style description
CBX: LDL_ITEM_STYLE.LDL_PRODUCT_DESC'
  ,color_descr                              COMMENT 'Item style color description. Non-standard textual entries referring to color descriptions.
CBX: LDL_ITEM_STYLE.LDL_FARBE'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'NFPO item variant defining styles.
CBX: LDL_ITEM_STYLE'
AS SELECT
   client_id
  ,mdm_item_style_sid
  ,style_cd
  ,style_name
  ,style_descr
  ,color_descr
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_STYLE_HIST
;