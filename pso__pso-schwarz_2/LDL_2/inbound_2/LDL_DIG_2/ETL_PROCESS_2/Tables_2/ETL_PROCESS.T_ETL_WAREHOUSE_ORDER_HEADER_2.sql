/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_ORDER_HEADER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juli 2023 11:36:28
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_ORDER_HEADER_2 (
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   WH_ORDER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) for warehouse order',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'Number uniquely identifying a document of outbound delivery orders',
   WH_ORDER_DOC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order ',
   WH_ORDER_CREATE_TMSP                TIMESTAMP_TZ    COMMENT 'The timestamp when the warehouse order was created ',
   WH_ORDER_SHIP_TYPE_NAME             VARCHAR(5)      COMMENT 'Type names for deliveries, which have the same type of destination, like e.g. packing stations',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_ORDER_HEADER PRIMARY KEY (WH_ORDER_SID) NOT ENFORCED
 )  COMMENT= 'ETL  table to support t_fact_warehouse_order_line_2';
