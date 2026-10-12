/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_SORT
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 12:30:18
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_SORT (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'lgnum ',
   SORT_STATION                        VARCHAR(100)    NOT NULL COMMENT 'Sort station name',
   SORT_SHELF                          VARCHAR(100)    NOT NULL COMMENT 'Sort shelf',
   SAP_SYS_NAME                        VARCHAR(100)    COMMENT 'SAP System Name',
   SAP_CLIENT_ID                       VARCHAR(100)    COMMENT 'SAP Client Identifier',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_SORT PRIMARY KEY (WH_SID, SORT_STATION, SORT_SHELF) NOT ENFORCED
 )  COMMENT= 'ETL  table to support t_fact_warehouse_processing';
