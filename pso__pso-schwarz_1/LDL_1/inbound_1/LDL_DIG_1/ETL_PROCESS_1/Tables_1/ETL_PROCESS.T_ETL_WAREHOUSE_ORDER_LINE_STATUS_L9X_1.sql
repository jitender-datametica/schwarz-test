/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_ORDER_LINE_STATUS_L9X_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 20. März 2024 11:02:43
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_ORDER_LINE_STATUS_L9X_1 (
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_POS_SID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   WH_ORDER_PROCESSING_STEP_CD         VARCHAR(10)     NOT NULL COMMENT 'A short  unique code for the warehouse processing step associated with the particular order line (e.g. Wareneingang, Verpacken, etc.)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   WH_ORDER_PROCESSING_STEP_STATUS_CD  VARCHAR(10)     COMMENT 'A short  unique code for the status_1 of  the warehouse processing step associated with the particular order line (e.g. nicht begonnen, beendet, etc.)',
   WH_STATUS_CHANGE_TMSP               TIMESTAMP_NTZ   COMMENT 'The timestamp when the status_1 of the warehouse processing step associated with the particular order line was changed.',
   WH_ORDER_CAT_CD                     VARCHAR(10)     COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_ORDER_LINE_STATUS_L9X PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_SID, WH_ORDER_PROCESSING_STEP_CD) NOT ENFORCED 
)  COMMENT = 'ETL  table to support loading the data coming from L9X related to the different warehouse processing steps and their status_1 changes for each order line within a document generated for a certain warehouse inbound or outbound movement (excl. dropshipments) in t_fact_warehouse_order_line_status.';
