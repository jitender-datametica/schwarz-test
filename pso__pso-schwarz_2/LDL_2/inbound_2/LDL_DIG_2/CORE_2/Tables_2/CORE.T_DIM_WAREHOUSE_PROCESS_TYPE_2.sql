/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_PROCESS_TYPE_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 16:47:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_PROCESS_TYPE_2 (
   WH_PROCESS_TYPE_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for warehouse process type (2010, 2011, etc)',
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   WH_PROCESS_TYPE_DESCR               VARCHAR(250)    NOT NULL COMMENT 'The description for warehouse process type (Normal picking , Mix-Picking)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_PROCESS_TYPE PRIMARY KEY (WH_PROCESS_TYPE_CD, WH_SID) NOT ENFORCED
 )  COMMENT= 'The minor dimension defines warehouse process type, which groups tasks with the same picking process. "2010" (= Normal picking), "2011" (=Mix-Picking), "2013" (=Picking again/Nachkommisionierung)';
