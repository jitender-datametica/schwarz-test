CREATE TABLE CORE_REL.T_NFPO_ITEM_WORKFLOW_STATUS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_workflow_status_id        NUMBER(38,0)     NOT NULL COMMENT 'PK Item_1 Workflow Status_1;',
   nfpo_item_workflow_status_descr     VARCHAR(250)     NOT NULL COMMENT 'Item_1 Workflow Status_1;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_WORKFLOW_STATUS PRIMARY KEY (nfpo_item_workflow_status_id) NOT ENFORCED 
)  COMMENT = 'NFPO Item_1 lifecycle status_1;
             Static data:
             1 : New
             2 : Design in Progress
             3 : Quality Data Completed
             4 : Design Completed
             5 : Confirmed to Buy
             6 : Rejected';
