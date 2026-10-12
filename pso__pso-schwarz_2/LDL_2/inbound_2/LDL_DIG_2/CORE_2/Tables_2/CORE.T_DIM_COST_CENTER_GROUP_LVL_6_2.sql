/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_GROUP_LVL_6_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 21. April 2022 10:44:14
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COST_CENTER_GROUP_LVL_6_2 (
   CC_GROUP_LVL6_NR                    VARCHAR(20)     NOT NULL COMMENT 'Unique identifier of the level 6 Cost Center Group',
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   CC_GROUP_LVL6_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 6 Cost Center Group in English',
   CC_GROUP_LVL6_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 6 Cost Center Group in German',
   CC_GROUP_LVL5_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level 5 Cost Center Group',
   CC_GROUP_LVL5_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 5 Cost Center Group in English',
   CC_GROUP_LVL5_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 5 Cost Center Group in German',
   CC_GROUP_LVL4_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level 4 Cost Center Group',
   CC_GROUP_LVL4_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 4 Cost Center Group in English',
   CC_GROUP_LVL4_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 4 Cost Center Group in German',
   CC_GROUP_LVL3_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level 3 Cost Center Group',
   CC_GROUP_LVL3_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in English',
   CC_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in German',
   CC_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level 2 Cost Center Group',
   CC_GROUP_LVL2_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in English',
   CC_GROUP_LVL2_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in German',
   CC_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'Unique identifier of the level1 Cost Center Group',
   CC_GROUP_LVL1_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in English',
   CC_GROUP_LVL1_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COST_CENTER_GROUP_LVL_6 PRIMARY KEY (CC_GROUP_LVL6_NR, CTRL_AREA_CD) NOT ENFORCED
 )  COMMENT= 'Cost Center Groups - level 6 in the hierarchy_2';
