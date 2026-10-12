CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_QUOTATION_HIST_1 (
   mdm_item_quotation_sid                   COMMENT 'Surrogate key of the item_1 quotation.
CBX: CNT_VQ.REF_NO'
  ,mdm_item_quotation_workflow_status_cd    COMMENT 'Code for the steps of the workflow for item_1 quotations.
CBX: CNT_VQ.STATUS_1'
  ,cbx_item_quotation_doc_status_cd         COMMENT 'Status_1 code to describe the general situation of the entity instance in the source system: Values are active, inactive and canceled.
CBX: CNT_VQ.DOC_STATUS'
  ,shipping_container_20ft_qty              COMMENT 'Quantity of standard 20 foot shipping containers to be used to deliver the items.
CBX: CNT_VQ.FT20_QTY'
  ,shipping_container_40ft_qty              COMMENT 'Quantity of standard 40 foot shipping containers to be used to deliver the items.
CBX: CNT_VQ.FT40_QTY'
  ,shipping_container_40ft_hc_qty           COMMENT 'Quantity of standard 40 foot high cube shipping containers to be used to deliver the items.
CBX: CNT_VQ.FT40_HC_QTY'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,client_id                                COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains information about quotations for items provided by suppliers.
CBX: CNT_VQ'
AS SELECT
   mdm_item_quotation_sid
  ,mdm_item_quotation_workflow_status_cd
  ,cbx_item_quotation_doc_status_cd
  ,shipping_container_20ft_qty
  ,shipping_container_40ft_qty
  ,shipping_container_40ft_hc_qty
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST_1
;