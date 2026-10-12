/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_LINE_STATUS_TIME_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. August 2024 11:37:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_ORDER_LINE_STATUS_TIME_1 (
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_POS_SID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SCHEDULED_WH_ORDER_POS_NR           NUMBER          NOT NULL COMMENT 'Not in use, always has same value. Could be used if the items in one position from one order are NOT sent at once, but on several batches.
            In such case there will be a schedule when each batch will be sent. In such case for each batch there will be a different value in this column.',
   WH_ORDER_PROCESSING_STEP_TIMING_CD  VARCHAR(20)     NOT NULL COMMENT 'Code that describes the type of step that is measured (in SAP it is represented as "time type", although it indicates what is the step of the process) - For example "PTAW" stands for "Putaway", "GOODSRECPT" stands for "goods receipt"',
   WH_ORDER_PROCESSING_STEP_TIMING_CAT_CD VARCHAR(20)     NOT NULL COMMENT 'Code that describes if the row has the "PLANNED" or "ACTUAL" timing values for the warehouse processing step',
   WH_ORDER_CAT_CD                     VARCHAR(6)      COMMENT 'The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   WH_ORDER_PROCESSING_STEP_START_TMSP TIMESTAMP_LTZ(9) COMMENT 'Timestamp indicating when the step starts',
   WH_ORDER_PROCESSING_STEP_END_TMSP   TIMESTAMP_LTZ(9) COMMENT 'Timestamp indicating when the step ends',
   WH_ORDER_PROCESSING_TIMING_CALCULATION_CD VARCHAR(5)      COMMENT 'A code that indicates how the row in the table was created.
            C - Value Determined By System
            M - Value Specified as Mandatory Manually; Change Value Manually
            E - Value Specified as Mandatory Externally and not Changeable
            P - Value Proposed Externally; Changeable Manually or by System
            " " - Initial State, Value to be redetermined by System',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_ORDER_LINE_STATUS_TIME PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_SID, SCHEDULED_WH_ORDER_POS_NR, WH_ORDER_PROCESSING_STEP_TIMING_CD, WH_ORDER_PROCESSING_STEP_TIMING_CAT_CD) NOT ENFORCED 
)  COMMENT = 'ETL  table to support loading the data coming from L8V related to the different warehouse processing steps and the time it takes to move from one step to another. 
             Fact table for duration of steps/statuses  of processing warehouse order line. 
             The source of the table is /SCDL/DB_DATE table from SAP EWM module.
             These statuses are highly related with data coming from /SCDL/DB_STATUS, stored in tables T_FACT_WAREHOUSE_ORDER_LINE_STATUS_1
             
             The data in this table is mainly derived data, Start/End times are automatically populated in DB_DATE when a status_1  (in DB_STATUS table) changes.
             The values in wh_order_processing_step_timing_cd show what type of step  we have, although they are not the same values as wh_order_processing_step_cd - they are derived 
             
             For example: At 10:00 in DB_STATUS, status_1 was set to "Receiving goods" this means in DB_DATE we have 10:00 as start of the "timing type" "receiving of goods"
             	when at 10:03 the status_1 in DB_STATS is set to "All Goods Received", then the End of timing type of "Receiving of goods" is set 10:03
             	and the new timing type is started
             
             The table contains rows for both PLANNED and ACTUAL values (wh_order_processing_step_timing_cat_cd)
             
             ';
