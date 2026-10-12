/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_LOGISTIC_INVENTORY_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. September 2022 14:52:21
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_LOGISTIC_INVENTORY_2 (
   WH_ORDER_SID                        NUMBER          COMMENT 'The unique identifier (sk) for warehouse order',
   WH_ORDER_POS_NR                     NUMBER          COMMENT 'The particular position number of a position in an order',
   ACTUAL_PICK_QTY                     NUMBER(38, 5)   COMMENT 'The actual quantity after the picking is fully done - when there is no warehouse task or wave assigned - then it means there is a real handling unit_2 physically picked.',
   GU_ID_PARENT                        VARCHAR(100)    NOT NULL COMMENT 'Src Field',
   GU_ID_STOCK                         VARCHAR(100)    NOT NULL COMMENT 'Src Field',
   SAP_CLIENT_ID                       VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   SAP_SYS_NAME                        VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   QDOCID                              VARCHAR(64)     COMMENT 'Src Field',
   QITEMID                             VARCHAR(64)     COMMENT 'Src Field',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_LOGISTIC_INVENTORY PRIMARY KEY (GU_ID_PARENT, GU_ID_STOCK, SAP_CLIENT_ID, SAP_SYS_NAME) NOT ENFORCED
 )  COMMENT= 'ETL  table to support t_fact_warehouse_processing_2';
