/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_VEHICLE_ITEM_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:27:26
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_VEHICLE_ITEM_2 (
   WH_SID                              NUMERIC(38,0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   VEHICLE_INTERNAL_NR                 VARCHAR(40)     NOT NULL COMMENT 'This number is the internal number of the trucks which carries the package.',
   DELIVERY_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'The order number from the SAP retail system that processes deliveries',
   PACK_TRACKING_NR                    VARCHAR(1000)   NOT NULL COMMENT 'The tracking ID which links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse',
   DELIVERY_ORDER_SID                  NUMERIC(38,0)   COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.', 
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration', 
   CONSTRAINT PK_T_ETL_WAREHOUSE_VEHICLE_ITEM PRIMARY KEY (WH_SID, VEHICLE_INTERNAL_NR, DELIVERY_ORDER_NR, PACK_TRACKING_NR) NOT ENFORCED 
)  COMMENT = 'An ETL table intended for loading core.t_fact_customer_package_shipment';
