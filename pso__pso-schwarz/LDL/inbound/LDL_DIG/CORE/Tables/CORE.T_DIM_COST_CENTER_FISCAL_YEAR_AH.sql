/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_FISCAL_YEAR_AH
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:38:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COST_CENTER_FISCAL_YEAR_AH (
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   COST_CENTER_NR                      VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center',
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year of the hierarchy',
   CC_GROUP_LVL1_NR                    VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center Group Lvl 1 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL1_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in English',
   CC_GROUP_LVL1_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in German',
   CC_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 2 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL2_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in English',
   CC_GROUP_LVL2_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in German',
   CC_GROUP_LVL3_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 3 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL3_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in English',
   CC_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in German',
   CC_GROUP_LVL4_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 4 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL4_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 4 Cost Center Group in English',
   CC_GROUP_LVL4_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 4 Cost Center Group in German',
   CC_GROUP_LVL5_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 5 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL5_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 5 Cost Center Group in English',
   CC_GROUP_LVL5_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 5 Cost Center Group in German',
   CC_GROUP_LVL6_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 6 to which this Cost Center belongs in the selected business year hierarchy',
   CC_GROUP_LVL6_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 6 Cost Center Group in English',
   CC_GROUP_LVL6_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 6 Cost Center Group in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COST_CENTER_FISCAL_YEAR_AH PRIMARY KEY (CTRL_AREA_CD, COST_CENTER_NR, FISCAL_YEAR, CC_GROUP_LVL1_NR) NOT ENFORCED
 )  COMMENT= 'Table that describes and historizes the fiscal year alternative hierarchies of Cost Center Groups and their relationship to Cost Center';
