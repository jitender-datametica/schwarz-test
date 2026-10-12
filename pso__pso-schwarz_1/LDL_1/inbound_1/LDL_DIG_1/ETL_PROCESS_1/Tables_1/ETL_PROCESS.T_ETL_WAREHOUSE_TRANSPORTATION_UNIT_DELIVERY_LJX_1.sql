/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_LJX_1
   GENERATED FROM POWERDESIGNER ON Montag, 10. Juni 2024 15:31:11
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_LJX_1 (
   WH_TRANSPORTATION_UNIT_SID          NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. ',
   WH_TRANSPORTATION_UNIT_ACTIVITY_NR  VARCHAR(20)     NOT NULL COMMENT 'The unique ID for the activity of the transportation unit_1 at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit_1 is docked at the warehouse. ',
   SEQ_NR                              NUMBER          NOT NULL COMMENT 'The unique sequence number related to a particular delivery transported on the given transportation unit. This field serves as counter only and has no business meaning on its own.',
   WH_TRANSPORTATION_UNIT_NR           VARCHAR(50)     COMMENT 'The unique internal ID for the warehouse transportation unit_1 delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit_1 number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit_1 number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr',
   WH_SID                              VARCHAR(20)     COMMENT 'The unique ID (surogate key) of the warehouse associated with the particular inbound or outbound movement.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouse associated with the particular inbound or outbound movement.',
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_POS_SID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   WH_ORDER_CAT_CD                     VARCHAR(6)      NOT NULL COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_LJX PRIMARY KEY (WH_TRANSPORTATION_UNIT_SID, WH_TRANSPORTATION_UNIT_ACTIVITY_NR, SEQ_NR) NOT ENFORCED 
)  COMMENT = 'ETL table to support loading the data coming from LJX related to warehouse transportation units. 
             Each transportation unit_1 carries specific deliveries.
             These deliveries are associated with specific order lines within a document generated for a certain warehouse inbound or outbound movement.
             The field wh_order_cat_cd shows the direction (inbound/outbound) of the deliveries.';
