/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_quotation_workflow_status_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_QUOTATION_WORKFLOW_STATUS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_quotation_workflow_status_cd VARCHAR(100)     NOT NULL COMMENT 'Code for the steps of the workflow for item_1 quotations.
            CBX: CNT_VQ.STATUS_1
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS.MDM_ITEM_QUOTATION_WORKFLOW_STATUS_CD',
   nfpo_item_quotation_workflow_status_descr VARCHAR(250)     COMMENT 'Description for the steps of the workflow for item_1 quotations.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS.MDM_ITEM_QUOTATION_WORKFLOW_STATUS_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_QUOTATION_WORKFLOW_STATUS PRIMARY KEY (nfpo_item_quotation_workflow_status_cd) NOT ENFORCED 
)  COMMENT = 'NFPO supplier_1 related quotation workflow steps.
             Manually filled values derived from: CBX: CNT_VQ.STATUS_1
             LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS_1';

