/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_workflow_status
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:45:15
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   workflow_status_id                  NUMBER(38,0)     NOT NULL COMMENT 'identifier of the NFPO item workflow status',
   workflow_status                     VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'assigned name of the NFPO item workflow status',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_WORKFLOW_STATUS PRIMARY KEY (workflow_status_id) NOT ENFORCED 
)  COMMENT = 'NFPO Item lifecycle status;
             Static data:
             1 : New
             2 : Design in Progress
             3 : Quality Data Completed
             4 : Design Completed
             5 : Confirmed to Buy
             6 : Rejected';
