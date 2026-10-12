CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_VEHICLE_HEADER_1 (
   WH_SID                              NUMERIC(38,0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   VEHICLE_INTERNAL_NR                 VARCHAR(40)     NOT NULL COMMENT 'This number is the internal number of the trucks which carries the package.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse',
   VEHICLE_DEPARTURE_TMSP              TIMESTAMP_TZ(9) COMMENT 'The timestamp when a truck departed from the warehouse',
   VEHICLE_LICENSE_PLATE_NR            VARCHAR(30)     COMMENT 'The licence plate number of the trucks which carries the package_1',
   VEHICLE_LOADING_START_TMSP          TIMESTAMP_TZ(9) COMMENT 'The timestamp when the loading in the truck started',
   VEHICLE_LOADING_END_TMSP            TIMESTAMP_TZ(9) COMMENT 'The timestamp when a truck is finished with loading',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_T_ETL_WAREHOUSE_VEHICLE_HEADER PRIMARY KEY (WH_SID, VEHICLE_INTERNAL_NR) NOT ENFORCED
)  COMMENT = 'An ETL table intended for loading core.t_fact_customer_package_shipment';
