/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_PICKED_STOCK_QUANTITY_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 16. Mai 2023 16:10:48
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_PICKED_STOCK_QUANTITY_1 (
   SAP_CLIENT_ID                       VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   SAP_SYS_NAME                        VARCHAR(20)     NOT NULL COMMENT 'Src Field',
   GU_ID_PARENT                        VARCHAR(100)    NOT NULL COMMENT 'Src Field',
   GU_ID_STOCK                         VARCHAR(100)    NOT NULL COMMENT 'Src Field',
   VIRTUAL_STOCK_INDICATOR             VARCHAR(5)      NOT NULL COMMENT 'Src Field',
   STOCK_UNIT_OF_MEASURE               VARCHAR(5)      NOT NULL COMMENT 'Src Field',
   ACTUAL_PICK_QTY                     NUMBER(38, 5)   COMMENT 'The actual quantity after the picking is fully done - when there is no warehouse task or wave assigned - then it means there is a real handling unit_1 physically picked.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_PICKED_STOCK_QUANTITY PRIMARY KEY (GU_ID_PARENT, GU_ID_STOCK, SAP_CLIENT_ID, SAP_SYS_NAME, VIRTUAL_STOCK_INDICATOR, STOCK_UNIT_OF_MEASURE) NOT ENFORCED
 )  COMMENT= 'ETL  table to support t_fact_warehouse_processing. Source SAP EWM (table LIME/NQUAN) 
             Contains data for open Warehouse Task - Reserve specific quantity for the Warehouse Task
             Entry will be set to zero when Warehouse Task is confirmed or cancelled';
