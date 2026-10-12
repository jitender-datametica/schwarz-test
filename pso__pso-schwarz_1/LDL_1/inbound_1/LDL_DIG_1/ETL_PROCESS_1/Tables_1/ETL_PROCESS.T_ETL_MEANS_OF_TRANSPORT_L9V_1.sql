/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_MEANS_OF_TRANSPORT_L9V_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 19. Februar 2025 10:38:21
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_MEANS_OF_TRANSPORT_L9V_1 (
   WH_ORDER_SID                        NUMERIC         NOT NULL COMMENT 'The unique identifier(surrogate key) for warehouse order',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   WH_ORDER_POS_SID                    NUMERIC(38,0)   NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   SCHEDULED_WH_ORDER_POS_NR           VARCHAR(64)     NOT NULL COMMENT 'Not in use, always has same value. Could be used if the items in one position from one order are NOT sent at once, but on several batches.
            In such case there will be a schedule when each batch will be sent. In such case for each batch there will be a different value in this column.',
   COUNTER_ID                          NUMERIC         NOT NULL COMMENT 'Used for foreign key relationship so that entries are restricted to those that appear within the primary key of the check table.',
   WH_ORDER_CAT_CD                     VARCHAR(6)      COMMENT 'The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   TRANSPORT_MODE_CD                   VARCHAR(20)     COMMENT 'This field indicates the mode of the transport means. It describes how the goods are being transported, such as by truck, ship, airplane, or train.Example: Currently not in use',
   TRANSPORT_MODE_ID                   VARCHAR(20)     COMMENT 'This is the unique identification number of the transport means. It can be a vehicle number, container number, or any other specific identifier that uniquely identifies the transport means.Example: E180624016L',
   TRANSPORT_MODE_TYPE_CD              VARCHAR(20)     COMMENT 'This field describes the type of the transport means. It indicates whether it is a container, trailer, ship, airplane, truck etc.
            
            Example: ZTRK',
   TRANSPORT_MODE_CATEGORY_CD          VARCHAR(20)     COMMENT 'This is a code that contains additional information about the transport means. It can be a standardized code that describes certain characteristics or classifications of the transport means.
            
            Example: 3002',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_MEANS_OF_TRANSPORT_L9V PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_SID, SCHEDULED_WH_ORDER_POS_NR, COUNTER_ID) NOT ENFORCED 
)  COMMENT = 'ETL  table  for means of transport / delivery transportation data. 
             
             Source: /SCDL/DB_TRANS table in  L9V source system.';
