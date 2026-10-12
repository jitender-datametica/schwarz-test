/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_DROPSHIPMENT_TRACKING_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:25:28
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_DROPSHIPMENT_TRACKING_1 (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier_1 Order Number present in the Purchase Order',
   PACK_TRACKING_NR                    VARCHAR(1000)   NOT NULL COMMENT 'ID, whcih links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url',
   PACK_TRACKING_URL                   VARCHAR(500)    COMMENT 'The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_DROPSHIPMENT_TRACKING PRIMARY KEY (SUPPLIER_ORDER_NR, PACK_TRACKING_NR) NOT ENFORCED 
)  COMMENT = 'The etl table to support tracking of dropshipment orders';
