/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_SCHEDULE_AGREEMENT_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 5. Januar 2023 14:53:46
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUPPLIER_ORDER_SCHEDULE_AGREEMENT_1 (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier_1 Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          NOT NULL COMMENT 'Product position number on purchase order',
   DELIVERY_SCHEDULE_LINE_NR           NUMERIC(4)      NOT NULL COMMENT 'ETENR (Delivery Schedule Line Counter)',
   ITEM_DELIVERY_DT                    DATE            COMMENT 'The agreement is made for the item_1 to be delivered at this date',
   PROD_QTY_SCHEDULED                  NUMBER(38, 3)   COMMENT 'Scheduled Quantity (Einteilungsmenge)',
   PROD_QTY_RECEIVED                   NUMBER(38, 3)   COMMENT 'Quantity of Goods Received (Gelieferte Menge)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUPPLIER_ORDER_SCHEDULE_AGREEMENT PRIMARY KEY (SUPPLIER_ORDER_NR, SUPPLIER_ORDER_POS_NR, DELIVERY_SCHEDULE_LINE_NR) NOT ENFORCED
 )  COMMENT= 'The ETL support table holding order position details (agreement delivery date) placed by Lidl purchase department ( DE ) from a supplier_1 ';
