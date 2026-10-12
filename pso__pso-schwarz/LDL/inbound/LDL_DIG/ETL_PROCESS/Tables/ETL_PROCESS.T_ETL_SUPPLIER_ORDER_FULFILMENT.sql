/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_FULFILMENT
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:33:40
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUPPLIER_ORDER_FULFILMENT (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          NOT NULL COMMENT 'Product position number on purchase order',
   VENDOR_CONFIRMATION_NR              NUMBER          NOT NULL COMMENT 'Idenfier of the vendor confirmation',
   SUPPLIER_ORDER_FULFILMENT_DT        DATE            COMMENT 'On this date the supplier confirmed that it will provide this product qunatity',
   DELIVERY_ORDER_SID                  NUMBER          COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DELIVERY_ORDER_NR                   VARCHAR(20)     COMMENT 'Delivery order number ',
   DELIVERY_ORDER_POS_NR               NUMBER          COMMENT 'The particular position number of a position in an order',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of the product that is confirmed will be delivered',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUPPLIER_ORDER_FULFILMENT PRIMARY KEY (SUPPLIER_ORDER_NR, SUPPLIER_ORDER_POS_NR, VENDOR_CONFIRMATION_NR) NOT ENFORCED
 )  COMMENT= 'The ETL support table holding the order position details placed by Lidl purchase department ( DE ) from a supplier ';
