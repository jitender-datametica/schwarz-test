/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_quotation_workflow_status_1
   generated from Powerdesigner on Montag, 1. Dezember 2025 11:36:17
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS_1 (
   mdm_item_quotation_workflow_status_cd VARCHAR(100)     NOT NULL COMMENT 'Code for the steps of the workflow for item_1 quotations.
            CBX: CNT_VQ.STATUS_1',
   mdm_item_quotation_workflow_status_descr VARCHAR(250)     COMMENT 'Description for the steps of the workflow for item_1 quotations.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS PRIMARY KEY (mdm_item_quotation_workflow_status_cd) NOT ENFORCED 
)  COMMENT = 'NFPO supplier_1 related quotation workflow steps.
             Manually filled values derived from: CBX: CNT_VQ.STATUS_1';
