/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 14:41:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_ORDER_LINE (
   WH_ORDER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for a warehouse order',
   WH_ORDER_POS_NR                     NUMBER          NOT NULL COMMENT 'The particular position number within a document of an outbound delivery order',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'Sales Organization/Webshop through which the order was placed',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'Number uniquely identifying a document of outbound delivery orders',
   WH_ORDER_POS_ID                     VARCHAR(80)     COMMENT 'A technical field, which is being used by business to filter on a specific warehouse-order-number-position-combination within the SAP GUI.',
   WH_ORDER_POS_SID                    NUMBER(38,0)    COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement (itemid in the source system).',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'Ordered product of outbound delivery order',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity per product of outbound delivery order',
   OUT_INVOICE_DT                      DATE            COMMENT 'Date of outgoing invoice document for a customer delivery order',
   WH_ORDER_DOC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order ',
   WH_GOODS_ISSUE_STATUS_CD            VARCHAR(5)      COMMENT 'The code for warehouse goods issue status -0,1,9',
   WH_ORDER_CREATE_TMSP                TIMESTAMP_TZ(9) COMMENT 'The timestamp when the warehouse order was created ',
   WH_ORDER_SHIP_TYPE_NAME             VARCHAR(5)      COMMENT 'Type names for deliveries, which have the same type of destination, like e.g. packing stations',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   IS_ORDER_IN_PROGRESS_FG             BOOLEAN         COMMENT 'This field indicates whether the warehouse order number and its associated tasks and waves are currently in progress. Based on this flag, the values are being taken into consideration within the Lager Cockpit or not',
   OUTBOUND_TMSP                       TIMESTAMP_TZ(9) COMMENT 'Date and time when the outbound process has happened',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_ORDER_LINE PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'This transactional fact tracks EWM ( SAP enterprise warehouse managent)  delivery documents of the warehouse.- a.k.a Warehouse Orders
             Such documents are created in the EWM system as a result of Delivery Orders in ERP system (see table T_FACT_GOODS_MOVEMENT)
             One ERP Delivery Order can be the reason for creating several warehouse orders.
             
             NOTE! This table contains Warehouse Orders related ONLY to OUTBOUND Delivery Orders. When the table was created it was believed these are the only goods movements in the EWM system that would be analyzed and imported in the DWH. However this is now changed and we have separate table for Inbound Warehouse Orders and at some point this table should be rename to T_FACT_OUTBOUND_WAREHOUSE_MOVEMENT maybe. 
             
             Historization is introduced to keep track of status progress,
             
             Main Src - SAP EWM  tables /SCDL/DB_PROCH_O and /SCDL/DB_PROCI_O';
