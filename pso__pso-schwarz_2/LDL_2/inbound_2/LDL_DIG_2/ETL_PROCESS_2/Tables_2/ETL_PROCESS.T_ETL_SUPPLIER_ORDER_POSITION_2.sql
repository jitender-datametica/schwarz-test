/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_POSITION_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:34:37
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUPPLIER_ORDER_POSITION_2 (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier_2 Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          NOT NULL COMMENT 'Product position number on purchase order',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a certain product ordered in a purchasing document',
   DELETION_IN_PURCH_DOC_CD            VARCHAR(5)      COMMENT 'Code indicating if position was deleted in purchasing document',
   DELETION_IN_PURCH_DOC_FG            BOOLEAN         COMMENT 'Flag indicating if position was deleted in purchasing document',
   DELIVERY_COMPLETED_CD               VARCHAR(5)      COMMENT 'Code indicating if delivery was completed',
   DELIVERY_COMPLETED_FG               BOOLEAN         COMMENT 'Flag indicating if delivery was completed',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUPPLIER_ORDER_POSITION PRIMARY KEY (SUPPLIER_ORDER_NR, SUPPLIER_ORDER_POS_NR) NOT ENFORCED
 )  COMMENT= 'The ETL support table holding the order position details placed by Lidl purchase department ( DE ) from a supplier_2 ';
