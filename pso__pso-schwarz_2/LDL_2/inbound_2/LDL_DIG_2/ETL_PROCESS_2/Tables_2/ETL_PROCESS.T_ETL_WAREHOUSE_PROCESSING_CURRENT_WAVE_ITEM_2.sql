/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_CURRENT_WAVE_ITEM_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 19. März 2024 11:28:45
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_CURRENT_WAVE_ITEM_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   RDOC_ID                             VARCHAR(64)     NOT NULL COMMENT 'Identifier',
   RITM_ID                             VARCHAR(64)     NOT NULL COMMENT 'Identifier',
   WH_ORDER_POS_SID                    NUMBER(38,0)    COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)',
   WAVE_ID                             NUMBER          NOT NULL COMMENT 'Wave Identifier',
   WAVE_POS_NR                         VARCHAR(10)     NOT NULL COMMENT 'wave position number',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   WAVE_ERROR                          VARCHAR(2)      COMMENT 'wave error',
   WH_ORDER_SID                        NUMBER          COMMENT 'The unique identifier (sk) for warehouse order',
   WH_ORDER_POS_NR                     NUMBER          COMMENT 'The particular position number of a position in an order',
   MAX_WAVE_QTY                        NUMBER(38, 5)   COMMENT 'The maximum wave item_2 quantity',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_CURRENT_WAVE_ITEM PRIMARY KEY (WH_SID, RDOC_ID, RITM_ID) NOT ENFORCED 
)  COMMENT = 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2';
