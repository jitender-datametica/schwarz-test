/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_WAVE_HEADER_2
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 12:25:51
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_WAVE_HEADER_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   WAVE_ID                             NUMBER          NOT NULL COMMENT 'Wave Identifier',
   WAVE_FG                             BOOLEAN         COMMENT 'Wave Flag',
   WAVE_HEADER_STATUS                  VARCHAR(2)      COMMENT 'Wave header status_2',
   WAVECAT_CD                          VARCHAR(20)     COMMENT 'Wave Cat Code ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_WAVE_HEADER PRIMARY KEY (WH_SID, WAVE_ID) NOT ENFORCED
 )  COMMENT= 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2';
