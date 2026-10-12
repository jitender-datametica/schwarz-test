/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_TASK_STATUS
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:18:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_TASK_STATUS (
   WH_TASK_STATUS_CD                   VARCHAR(5)      NOT NULL COMMENT 'The code for warehouse task status',
   WH_TASK_STATUS_DESCR                VARCHAR(250)    NOT NULL COMMENT 'The description for warehouse task status',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_TASK_STATUS PRIMARY KEY (WH_TASK_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension defines warehouse task status';
