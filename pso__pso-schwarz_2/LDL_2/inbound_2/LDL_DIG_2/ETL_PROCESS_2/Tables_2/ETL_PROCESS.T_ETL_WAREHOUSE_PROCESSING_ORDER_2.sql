/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_ORDER_2
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 14:42:07
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_ORDER_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_ORDER_SID                        NUMBER          NOT NULL COMMENT 'Surrogate Key for warehouse order',
   WH_ORDER_POS_NR                     NUMBER          NOT NULL COMMENT 'Position Number',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DOC_CAT                             VARCHAR(6)      NOT NULL COMMENT 'Document Category',
   DOC_NO                              VARCHAR(20)     COMMENT 'Document Number',
   ITEM_NO                             NUMBER          COMMENT 'Position number',
   WH_ORDER_POS_SID                    NUMBER(38,0)    COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement (itemid in the source system).',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'Number uniquely identifying a document of outbound delivery orders',
   DOC_ID                              VARCHAR(64)     NOT NULL COMMENT 'Document ID',
   ITEM_ID                             VARCHAR(64)     NOT NULL COMMENT 'Item_2 Id ',
   WAVE_CD                             VARCHAR(5)      COMMENT 'Wave Flag',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   HU_ID                               VARCHAR(64)     COMMENT 'Identifier',
   GUID_PARENT_CD                      VARCHAR(64)     COMMENT 'Needed for Ludwigsfelde Lager Cockpit in where condition in update sql t_fact_warehouse_processing_2 to map referenced guid',
   GUID_LAGP_CD                        VARCHAR(64)     COMMENT 'Needed for Ludwigsfelde Lager Cockpit in update sql t_fact_warehouse_processing_2 to calculate filed flag_quittiert_clearing',
   SCWM_PROCTY                         VARCHAR(8)      COMMENT 'Sap Client Identifier',
   SAP_CLIENT_ID                       VARCHAR(20)     COMMENT 'Sap Client Identifier',
   SAP_SYS_NAME                        VARCHAR(20)     COMMENT 'Sap System Name',
   WHO_STATUS_CD                       VARCHAR(20)     COMMENT 'Status_2 Code',
   TO_STATUS_CD                        VARCHAR(20)     COMMENT 'Status_2 Code',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered',
   WH_GOODS_ISSUE_STATUS_CD            VARCHAR(5)      COMMENT 'The code for warehouse goods issue status_2 -0,1,9',
   OUT_INVOICE_DT                      DATE            COMMENT 'Date of outgoing invoice document for a customer delivery order',
   OUTBOUND_TMSP                       TIMESTAMP_TZ    COMMENT 'Date and time when the outbound process has happened',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_ORDER PRIMARY KEY (DWH_VALID_FROM_TMSP, WH_ORDER_POS_NR, WH_ORDER_SID, WH_SID) NOT ENFORCED 
)  COMMENT = 'ETL  table to support t_fact_warehouse_order_line_2';
