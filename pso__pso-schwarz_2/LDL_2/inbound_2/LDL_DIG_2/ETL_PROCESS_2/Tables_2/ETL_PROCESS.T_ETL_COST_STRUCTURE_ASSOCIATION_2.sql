/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_STRUCTURE_ASSOCIATION_2
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:17
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COST_STRUCTURE_ASSOCIATION_2 (
   COST_ITEM                           VARCHAR(20)     NOT NULL COMMENT 'Identifier of the lower level Cost Center/Cost Element',
   HIERARCHY_GROUP_NR                  VARCHAR(20)     NOT NULL COMMENT 'Identifier of the associated lower level Cost Center/Cost Element group',
   COST_STRUCTURE_TYPE_CD              VARCHAR(5)      COMMENT 'Code of the Cost Structure',
   CTRL_AREA_CD                        VARCHAR(5)      COMMENT 'Code of the Controlling Area',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COST_STRUCTURE_ASSOCIATION PRIMARY KEY (COST_ITEM, HIERARCHY_GROUP_NR) NOT ENFORCED
 )  COMMENT= 'Table that contains the relationships between the cost center/cost element and the correspondent lowest group level per each hierarchy_2';
