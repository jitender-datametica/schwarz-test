/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_INBOUND_HEADER_LJX
   GENERATED FROM POWERDESIGNER ON Dienstag, 2. Juli 2024 13:32:33
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_INBOUND_HEADER_LJX (
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse inbound movement. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse inbound movement. (docid in the source system)',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'The number of the document generated for the particular warehouse inbound movement.',
   WH_ORDER_CAT_CD                     VARCHAR(6)      COMMENT 'The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   WH_DELIVERY_CREATE_TMSP             TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the delivery was created in the EWM SAP system (NOT when it arrived into the warehouse).',
   ADVANCED_SHIP_NOTIFICATION_NR       VARCHAR(70)     COMMENT 'The unique ID for the advanced shipping notification which can come from the SAP ERP system or from another system external to LIDL Digital. In case the notification comes from SAP ERP, the advanced shipping notification number = delivery_order_nr. ',
   WH_SID                              VARCHAR(20)     COMMENT 'The unique ID (surogate key) of the warehouse associated with the particular inbound movement.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse associated with the particular inbound movement.',
   WH_ORDER_DOC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_INBOUND_HEADER_LJX PRIMARY KEY (WH_ORDER_SID) NOT ENFORCED 
)  COMMENT = 'ETL  table to support loading inbound warehouse movement data at header level  from LJX.';
