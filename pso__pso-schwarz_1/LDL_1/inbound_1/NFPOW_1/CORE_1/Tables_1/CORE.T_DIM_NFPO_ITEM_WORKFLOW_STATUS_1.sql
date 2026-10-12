/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_workflow_status_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_WORKFLOW_STATUS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_workflow_status_id        NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the NFPO item_1 workflow status.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.WORKFLOW_STATUS_ID',
   nfpo_item_workflow_status_descr     VARCHAR(250)     NOT NULL COMMENT 'Assigned name of the NFPO item_1 workflow status.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.WORKFLOW_STATUS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_WORKFLOW_STATUS PRIMARY KEY (nfpo_item_workflow_status_id) NOT ENFORCED 
)  COMMENT = 'NFPO Item_1 workflow status_1;
             Static data:
             1 : New
             2 : Design in Progress
             3 : Quality Data Completed
             4 : Design Completed
             5 : Confirmed to Buy
             6 : Rejected';

