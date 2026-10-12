/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT_REFERENCE_LJX_2
   GENERATED FROM POWERDESIGNER ON Montag, 29. April 2024 09:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT_REFERENCE_LJX_2 (
   HANDLING_UNIT_SID                   NUMBER          NOT NULL COMMENT 'Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_CAT_CD                     VARCHAR(6)      NOT NULL COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   SRC_HANDLING_UNIT_ID                VARCHAR(64)     COMMENT 'The ID of the Handling Unit_2 in the source system
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT_REFERENCE_LJX PRIMARY KEY (HANDLING_UNIT_SID, WH_ORDER_SID, WH_ORDER_CAT_CD) NOT ENFORCED 
)  COMMENT = 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2 from LJX source system.
             
             The reason WH_ORDER_SID is also part of the PK is because in some occasions it is not known and we have a default value, so in this case in one handling_unit_2 we can have two different wh_order_cat_cd (for inbound and outbound).';
