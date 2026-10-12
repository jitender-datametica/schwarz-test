/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_1
   GENERATED FROM POWERDESIGNER ON Montag, 17. Juni 2024 10:06:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_1 (
   WH_TRANSPORTATION_UNIT_SID          NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key for the warehouse transportation unit_1 delivering the products associated with the given document order line.',
   WH_TRANSPORTATION_UNIT_ACTIVITY_NR  VARCHAR(20)     NOT NULL COMMENT 'The unique ID for the activity of the transportation unit_1 at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit_1 is docked at the warehouse.',
   SEQ_NR                              NUMBER          NOT NULL COMMENT 'The unique sequence number related to a particular delivery transported on the given transportation unit. This field serves as counter only and has no business meaning on its own.',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_TRANSPORTATION_UNIT_NR           VARCHAR(50)     COMMENT 'The unique ID coming from the source for the warehouse transportation unit_1 delivering the products associated with the given document order line.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   WH_ORDER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for a warehouse order',
   WH_ORDER_POS_SID                    NUMBER(38,0)    COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   WH_ORDER_CAT_CD                     VARCHAR(10)     COMMENT 'The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY PRIMARY KEY (WH_TRANSPORTATION_UNIT_SID, WH_TRANSPORTATION_UNIT_ACTIVITY_NR, SEQ_NR) NOT ENFORCED 
)  COMMENT = 'A Fact table that contains the details regarding the activities of the warehouse transportation units. Activities in this table represent deliveries/transportation-unit_1-movements "in" or "out" of the warehouse. The field wh_order_cat_cd shows the direction (inbound/outbound) of the deliveries..
             ';
