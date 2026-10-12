/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_TASK_ORDER_1
   GENERATED FROM POWERDESIGNER ON Samstag, 1. Oktober 2022 12:17:28
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_TASK_ORDER_1 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   WHO_ID                              NUMBER          NOT NULL COMMENT 'Identifier',
   WHO_STATUS_CD                       VARCHAR(2)      COMMENT 'Identifier',
   WHO_QUEUE_CD                        VARCHAR(20)     COMMENT 'Identifier',
   WHO_LGNUM_CD                        VARCHAR(8)      NOT NULL COMMENT 'Identifier',
   SAP_SYS_NAME                        VARCHAR(20)     COMMENT 'Name',
   SAP_CLIENT_ID                       VARCHAR(20)     COMMENT 'Identifier',
   CREATED_AT_TMSP                     TIMESTAMP_TZ    COMMENT 'Timestamp',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_TASK_ORDER PRIMARY KEY (WH_SID, WHO_ID, WHO_LGNUM_CD) NOT ENFORCED
 )  COMMENT= 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING_1';
