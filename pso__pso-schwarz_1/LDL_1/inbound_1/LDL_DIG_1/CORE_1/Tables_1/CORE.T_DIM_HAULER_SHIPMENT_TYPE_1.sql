/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_HAULER_SHIPMENT_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Juni 2023 09:42:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HAULER_SHIPMENT_TYPE_1 (
   HAULER_SHIP_TYPE_ID                 VARCHAR(50)     NOT NULL COMMENT 'The unique identifier for available shipment modes for carrier that is coming from source system',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   HAULER_NAME                         VARCHAR(100)    COMMENT 'The name by which the hauler is known',
   HAULER_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   HAULER_SHIP_TYPE_DESC               VARCHAR(250)    COMMENT 'A textual description for the carrirer shipment mode.',
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   DELIVERY_TYPE_NAME                  VARCHAR(100)    COMMENT 'A textual description for the package_1 delivery type  ',
   PACK_RETURN_TYPE_NAME               VARCHAR(100)    COMMENT 'A textual description for the package_1 return type  (label , pick_up )',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_DIM_HAULER_SHIPMENT_TYPE PRIMARY KEY (HAULER_SHIP_TYPE_ID) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the available shipment modes for carrier';
