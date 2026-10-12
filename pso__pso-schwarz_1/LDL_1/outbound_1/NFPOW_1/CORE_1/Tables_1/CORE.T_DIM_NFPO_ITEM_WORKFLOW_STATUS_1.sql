/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_workflow_status_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_workflow_status_1 (
nfpo_item_workflow_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the NFPO item_1 workflow status.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.WORKFLOW_STATUS_ID'),
nfpo_item_workflow_status_descr STRING(250) NOT NULL
OPTIONS(description='Assigned name of the NFPO item_1 workflow status.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.WORKFLOW_STATUS'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_workflow_status_id) NOT ENFORCED
)
OPTIONS(description='NFPO Item_1 workflow status_1;             Static data:             1 : New             2 : Design in Progress             3 : Quality Data Completed             4 : Design Completed             5 : Confirmed to Buy             6 : Rejected');