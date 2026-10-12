/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_quotation_workflow_status
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_quotation_workflow_status (
nfpo_item_quotation_workflow_status_cd STRING(100) NOT NULL
OPTIONS(description='Code for the steps of the workflow for item quotations.            CBX: CNT_VQ.STATUS            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS.MDM_ITEM_QUOTATION_WORKFLOW_STATUS_CD'),
nfpo_item_quotation_workflow_status_descr STRING(250)
OPTIONS(description='Description for the steps of the workflow for item quotations.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS.MDM_ITEM_QUOTATION_WORKFLOW_STATUS_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_quotation_workflow_status_cd) NOT ENFORCED
)
OPTIONS(description='NFPO supplier related quotation workflow steps.             Manually filled values derived from: CBX: CNT_VQ.STATUS             LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUOTATION_WORKFLOW_STATUS');