/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RETURN_PACKAGE_SHIPMENT_PRODUCT_VARIANT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:55
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_RETURN_PACKAGE_SHIPMENT_PRODUCT_VARIANT_1 (
   RETURN_PACK_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) for the return package_1',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant of the returned product',
   RETURN_REQUEST_NR                   VARCHAR(50)     COMMENT 'Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.',
   RETURN_PACK_TRACKING_NR             VARCHAR(1000)   COMMENT 'ID, which links the shipment of the return (from customer to Lidl Digital) with the actual package_1 and can also be searched for within the the carrier url',
   SALE_ORDER_SID                      NUMBER          COMMENT 'The unique identifier  for the sales_1 order ( can be customer or intercompany order)',
   SALE_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   SALE_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item_1 in an order',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product returned.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_RETURN_PACKAGE_SHIPMENT_PRODUCT_VARIANT PRIMARY KEY (RETURN_PACK_SID, PROD_VARIANT_SID) NOT ENFORCED 
)  COMMENT = 'Stores the return package_1 shipment product variant data.';
