/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_ELEMENT_GROUP_HIERARCHY_2
   GENERATED FROM POWERDESIGNER ON Montag, 27. Februar 2023 10:06:46
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COST_ELEMENT_GROUP_HIERARCHY_2 (
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area ',
   CHILD_CE_GROUP_NR                   VARCHAR(20)     NOT NULL COMMENT 'Identifier of the lower level Cost Element Group (child)',
   PARENT_CE_GROUP_NR                  VARCHAR(20)     NOT NULL COMMENT 'Identifier of the higher level Cost Element Group  (parent)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COST_ELEMENT_GROUP_HIERARCHY PRIMARY KEY (CTRL_AREA_CD, CHILD_CE_GROUP_NR) NOT ENFORCED
 )  COMMENT= 'This ETL table contains all hierarchical parent-child relationships for Cost Element Groups';
