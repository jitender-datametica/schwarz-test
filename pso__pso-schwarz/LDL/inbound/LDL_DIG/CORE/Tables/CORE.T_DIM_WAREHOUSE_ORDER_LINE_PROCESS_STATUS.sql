/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ORDER_LINE_PROCESS_STATUS
   GENERATED FROM POWERDESIGNER ON  2023-05-15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_ORDER_LINE_PROCESS_STATUS (
   WH_ORDER_LINE_PROCESS_STATUS_CD     NUMBER          NOT NULL COMMENT 'The processing status of a certaing Warehouse Order Line in a Wave',
   WH_ORDER_LINE_PROCESS_STATUS_DESCR  VARCHAR(250)    NOT NULL COMMENT 'The description of processing status of a certaing Warehouse Order Line in a Wave',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_ORDER_LINE_PROCESS_STATUS PRIMARY KEY (WH_ORDER_LINE_PROCESS_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension defines warehouse order line  processing statuses in a Wave - documents within a warehouse task process (''Nicht in Welle'', ''In Welle (nicht freigegeben)'', etc)';