/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 09:58:36
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   HU_ID                               VARCHAR(64)     NOT NULL COMMENT 'Identifier',
   SORT_TROLLEY_NAME                   VARCHAR(40)     COMMENT 'Identifier',
   WSBIN                               VARCHAR(36)     COMMENT 'Identifier',
   WTCONF_CD                           TIMESTAMP_TZ    COMMENT 'Timestamp',
   AQUA_HUIDENT_CD                     VARCHAR(40)     COMMENT 'Identifier',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT PRIMARY KEY (WH_SID, HU_ID) NOT ENFORCED
 )  COMMENT= 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING';
