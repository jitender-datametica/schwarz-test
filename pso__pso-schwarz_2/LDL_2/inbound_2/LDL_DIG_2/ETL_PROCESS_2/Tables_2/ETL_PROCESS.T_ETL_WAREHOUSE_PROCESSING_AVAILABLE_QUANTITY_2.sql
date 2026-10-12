/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_AVAILABLE_QUANTITY_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. September 2022 14:51:39
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_AVAILABLE_QUANTITY_2 (
   LGPLA                               VARCHAR(36)     NOT NULL COMMENT 'Storage Bin',
   HUIDENT                             VARCHAR(40)     NOT NULL COMMENT 'Identifier',
   GU_ID_STOCK                         VARCHAR(100)    NOT NULL COMMENT 'Src Field',
   RS_RC                               VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   SAP_CLIENT_ID                       VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   SAP_SYS_NAME                        VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   WH_CD                               VARCHAR(5)      COMMENT 'lgnum ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_AVAILABLE_QUANTITY PRIMARY KEY (LGPLA, HUIDENT, GU_ID_STOCK, RS_RC, SAP_CLIENT_ID, SAP_SYS_NAME) NOT ENFORCED
 )  COMMENT= 'ETL  table to support t_fact_warehouse_order_line_2';
