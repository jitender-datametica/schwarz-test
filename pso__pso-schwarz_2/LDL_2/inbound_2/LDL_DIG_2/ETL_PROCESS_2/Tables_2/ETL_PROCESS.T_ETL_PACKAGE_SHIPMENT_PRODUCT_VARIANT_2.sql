/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PACKAGE_SHIPMENT_PRODUCT_VARIANT_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:02
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_PACKAGE_SHIPMENT_PRODUCT_VARIANT_2 (
   PACK_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) for the package_2',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant of the returned product',
   PACK_TRACKING_NR                    VARCHAR(1000)   COMMENT 'The tracking ID which links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url',
   SALE_ORDER_SID                      NUMBER          COMMENT 'The unique identifier  for the sales_2 order ( can be customer or intercompany order)',
   SALE_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   SALE_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item_2 in an order',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product returned.',
   ADDITIONAL_SERVICES_DESC            VARCHAR(1000)   COMMENT 'Text describing additional characteristics of delivery service. ',
   DELIVERY_TO_POINT_OF_USE_FG         BOOLEAN         COMMENT 'Flag indicating if the product will be delivered to the point of use.',
   DELIVERY_PICK_UP_FOR_RECYCLING_FG   BOOLEAN         COMMENT 'Flag that the old device will be picked up with the delivery of the new',
   DELIVERY_LABEL_FOR_RECYCLING_FG     BOOLEAN         COMMENT 'Flag indicating that the customer will send the old device with a label. No pick-up.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_PACKAGE_SHIPMENT_PRODUCT_VARIANT PRIMARY KEY (PACK_SID, PROD_VARIANT_SID) NOT ENFORCED 
)  COMMENT = 'Stores information provided by carrier for forward shipments at the level of  Product Variant per Package_2';
