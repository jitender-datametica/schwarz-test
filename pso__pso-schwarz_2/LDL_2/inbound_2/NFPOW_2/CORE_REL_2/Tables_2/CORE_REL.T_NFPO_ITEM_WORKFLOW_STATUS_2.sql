CREATE TABLE CORE_REL.T_NFPO_ITEM_WORKFLOW_STATUS_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_workflow_status_id        NUMBER(38,0)     NOT NULL COMMENT 'PK Item_2 Workflow Status_2;',
   nfpo_item_workflow_status_descr     VARCHAR(250)     NOT NULL COMMENT 'Item_2 Workflow Status_2;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_WORKFLOW_STATUS PRIMARY KEY (nfpo_item_workflow_status_id) NOT ENFORCED 
)  COMMENT = 'NFPO Item_2 lifecycle status_2;
             Static data:
             1 : New
             2 : Design in Progress
             3 : Quality Data Completed
             4 : Design Completed
             5 : Confirmed to Buy
             6 : Rejected';
