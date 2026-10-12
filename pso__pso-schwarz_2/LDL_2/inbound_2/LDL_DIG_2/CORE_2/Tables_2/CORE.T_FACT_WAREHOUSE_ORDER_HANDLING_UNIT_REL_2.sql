/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_HANDLING_UNIT_REL_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Mai 2024 16:46:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_ORDER_HANDLING_UNIT_REL_2 (
   HANDLING_UNIT_SID                   NUMBER          NOT NULL COMMENT 'Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   WH_ORDER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for a warehouse order',
   WH_ORDER_CAT_CD                     VARCHAR(10)     NOT NULL COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   SRC_HANDLING_UNIT_ID                VARCHAR(64)     COMMENT 'The ID of the Handling Unit_2 in the source system
            A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. ',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_ORDER_HANDLING_UNIT_REL PRIMARY KEY (HANDLING_UNIT_SID, WH_ORDER_SID, WH_ORDER_CAT_CD) NOT ENFORCED 
)  COMMENT = 'A Relational Table that relates warehouse orders with handling units. A Handling unit_2 is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. 
             ';
