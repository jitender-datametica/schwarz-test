CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS_1 (
   mdm_item_quotation_workflow_status_cd    COMMENT 'Code for the steps of the workflow for item_1 quotations.
CBX: CNT_VQ.STATUS_1'
  ,mdm_item_quotation_workflow_status_descr COMMENT 'Description for the steps of the workflow for item_1 quotations.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'NFPO supplier_1 related quotation workflow steps.
Manually filled values derived from: CBX: CNT_VQ.STATUS_1'
AS SELECT
   mdm_item_quotation_workflow_status_cd
  ,mdm_item_quotation_workflow_status_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS_1
;