/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_CENTER_HIERARCHY_2
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Februar 2023 12:00:42
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COST_CENTER_HIERARCHY_2 (
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   CHILD_COST_CENTER                   VARCHAR(20)     NOT NULL COMMENT 'Identifier of the lower level Cost Center (child)',
   PARENT_COST_CENTER                  VARCHAR(20)     COMMENT 'Identifier of the higher level Cost Center (parent)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COST_CENTER_HIERARCHY PRIMARY KEY (CTRL_AREA_CD, CHILD_COST_CENTER) NOT ENFORCED
 )  COMMENT= 'This ETL table contains all hierarchical parent-child relationships for Cost Centers';
