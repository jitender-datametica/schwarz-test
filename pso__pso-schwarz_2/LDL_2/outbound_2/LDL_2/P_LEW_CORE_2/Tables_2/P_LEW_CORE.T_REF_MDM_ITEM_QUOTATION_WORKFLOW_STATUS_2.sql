/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_quotation_workflow_status_2
   generated from Powerdesigner on Montag, 1. Dezember 2025 11:36:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_quotation_workflow_status_2 (
mdm_item_quotation_workflow_status_cd STRING(100) NOT NULL
OPTIONS(description='Code for the steps of the workflow for item_2 quotations.            CBX: CNT_VQ.STATUS_2'),
mdm_item_quotation_workflow_status_descr STRING(250)
OPTIONS(description='Description for the steps of the workflow for item_2 quotations.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_quotation_workflow_status_cd) NOT ENFORCED
)
OPTIONS(description='NFPO supplier_2 related quotation workflow steps.             Manually filled values derived from: CBX: CNT_VQ.STATUS_2');