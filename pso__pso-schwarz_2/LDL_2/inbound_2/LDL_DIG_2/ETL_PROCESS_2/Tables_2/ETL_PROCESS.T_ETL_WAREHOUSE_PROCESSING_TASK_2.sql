/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_TASK_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 28. Februar 2023 13:09:50
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_TASK_2 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'Warehouse code',
   WHO_ID                              NUMBER          COMMENT 'Identifier',
   RDOC_ID                             VARCHAR(64)     COMMENT 'Identifier',
   RITM_ID                             VARCHAR(64)     COMMENT 'Identifier',
   HU_ID                               VARCHAR(64)     COMMENT 'Identifier',
   WH_TASK_STATUS_CD                   VARCHAR(5)      NOT NULL COMMENT 'Task status_2 code',
   TAPOS_NR                            VARCHAR(20)     NOT NULL COMMENT 'Source Field',
   NLPLA_CD                            VARCHAR(36)     COMMENT 'Code',
   TOSTAT_CD                           VARCHAR(5)      COMMENT 'Code',
   RDOCCAT_CD                          VARCHAR(10)     COMMENT 'Code',
   CREATED_AT_TMSP                     TIMESTAMP_TZ    COMMENT 'Created timestamp',
   WHO_STATUS_CD                       VARCHAR(2)      COMMENT 'Code',
   WHO_QUEUE_CD                        VARCHAR(20)     COMMENT 'Code',
   VLPLA_CD                            VARCHAR(36)     COMMENT 'Code',
   TASK_CD                             VARCHAR(20)     NOT NULL COMMENT 'Code',
   PROCTY_CD                           VARCHAR(20)     COMMENT 'Code',
   DOC_ID                              VARCHAR(64)     COMMENT 'Document ID',
   ITEM_ID                             VARCHAR(64)     COMMENT 'Item_2 Id ',
   QDOC_ID                             VARCHAR(64)     COMMENT 'Document ID',
   QITEM_ID                            VARCHAR(64)     COMMENT 'Item_2 Id ',
   SGUID_HU_CD                         VARCHAR(64)     COMMENT 'Identifier',
   DGUID_HU_CD                         VARCHAR(64)     COMMENT 'Identifier',
   FLGHUTO_CD                          VARCHAR(5)      COMMENT 'Identifier',
   SAP_CLIENT_ID                       VARCHAR(20)     COMMENT 'Code',
   SAP_SYS_NAME                        VARCHAR(20)     COMMENT 'Code',
   NLENR_CD                            VARCHAR(20)      COMMENT 'The column contains the information of Destination Handling Unit_2',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_TASK PRIMARY KEY (WH_SID, WH_TASK_STATUS_CD, TAPOS_NR, TASK_CD) NOT ENFORCED
 )  COMMENT= 'ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2';
