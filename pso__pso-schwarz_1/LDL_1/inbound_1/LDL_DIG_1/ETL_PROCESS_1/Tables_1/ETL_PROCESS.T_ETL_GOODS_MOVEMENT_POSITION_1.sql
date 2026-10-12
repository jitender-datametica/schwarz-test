/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_POSITION_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:35:02
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_GOODS_MOVEMENT_POSITION_1 (
   DELIVERY_ORDER_SID                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DELIVERY_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Delivery order number ',
   DELIVERY_ORDER_POS_NR               NUMBER          NOT NULL COMMENT 'The particular position number of a position in an order',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   DELIVERY_PROD_QTY                   NUMBER(38, 5)   COMMENT 'Quantity of products to be delivered',
   CUST_ORDER_SID                      NUMBER          COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item_1 in an order',
   CUST_ORDER_RETURN_NR                VARCHAR(20)     COMMENT 'An original return order number',
   CUST_ORDER_RETURN_POS_NR            NUMBER          COMMENT 'A number of an particular position ( product ) in an return order',
   STORAGE_LOC_CD                      VARCHAR(10)     COMMENT 'The code which identifies the storage location_1 (10001, 1002, etc)',
   SALE_DOC_TYPE_CD                    VARCHAR(5)      COMMENT 'The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )',
   ORDER_ITEM_CATEGORY_CD              VARCHAR(5)      COMMENT 'The code to uniquely identify the order item_1 categories',
   DROPSHIPMENT_ORDER_FG               BOOLEAN         COMMENT 'In case the material is being sent from the supplier_1 this field will be filled.',
   SUPPLIER_ORDER_NR                   VARCHAR(20)     COMMENT 'Supplier_1 Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          COMMENT 'Product position number on purchase order',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_GOODS_MOVEMENT_POSITION PRIMARY KEY (DELIVERY_ORDER_SID, DELIVERY_ORDER_POS_NR) NOT ENFORCED
 )  COMMENT= 'The etl support table for goods movement position fact';
