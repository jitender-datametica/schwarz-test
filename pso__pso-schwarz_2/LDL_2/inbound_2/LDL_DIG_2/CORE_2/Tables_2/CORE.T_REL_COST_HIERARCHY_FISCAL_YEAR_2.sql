/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_COST_HIERARCHY_FISCAL_YEAR_2
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_COST_HIERARCHY_FISCAL_YEAR_2 (
   FISCAL_YEAR                         NUMBER(38,0)    NOT NULL COMMENT 'A number that represents the fiscal year of the hierarchy_2',
   CTRL_AREA_CD                        VARCHAR(5)      COMMENT 'Code of the Controlling Area',
   CC_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level1 Cost Center Group',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      COMMENT 'Unique Identifier of the Chart of Accounts',
   CE_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'U nique identifier of the  level 1 Cost Element Group',
   CE_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'U nique identifier of the  level 2 Cost Element Group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_COST_HIERARCHY_FISCAL_YEAR PRIMARY KEY (FISCAL_YEAR) NOT ENFORCED
 )  COMMENT= 'Table that contains per each fiscal year the highest hierarchies level per cost centers and cost elements, to identify which hierarchy_2 is used in each fiscal year';
