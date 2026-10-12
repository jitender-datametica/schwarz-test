/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_STORAGE_PLACE
   GENERATED FROM POWERDESIGNER ON Donnerstag, 29. September 2022 08:50:06
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_STORAGE_PLACE (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   GU_ID_PARENT                        VARCHAR(100)    NOT NULL COMMENT 'GU Identifier',
   STORAGE_PLACE_LGPLA                 VARCHAR(20)     COMMENT 'Storage Place',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_STORAGE_PLACE PRIMARY KEY (WH_SID, GU_ID_PARENT) NOT ENFORCED
 )  COMMENT= 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING';
