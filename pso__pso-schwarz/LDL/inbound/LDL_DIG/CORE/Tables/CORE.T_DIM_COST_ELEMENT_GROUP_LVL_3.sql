/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_COST_ELEMENT_GROUP_LVL_3
   GENERATED FROM POWERDESIGNER ON Sonntag, 13. Februar 2022 16:16:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COST_ELEMENT_GROUP_LVL_3 (
   CE_GROUP_LVL3_NR                    VARCHAR(20)     NOT NULL COMMENT 'U nique identifier of the  level 3 Cost Element Group',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      NOT NULL COMMENT 'Unique Identifier of the Chart of Accounts',
   CE_GROUP_LVL3_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Element Group in English',
   CE_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Name of the  level 3 Cost Element Group in German',
   CE_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'U nique identifier of the  level 2 Cost Element Group',
   CE_GROUP_LVL2_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Element Group in English',
   CE_GROUP_LVL2_NAME_DE               VARCHAR(100)    COMMENT 'Name of the  level 2 Cost Element Group in German',
   CE_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'U nique identifier of the  level 1 Cost Element Group',
   CE_GROUP_LVL1_NAME_EN               VARCHAR(100)    COMMENT 'Name of the  level 1 Cost Element Group in English',
   CE_GROUP_LVL1_NAME_DE               VARCHAR(100)    COMMENT 'Name of the  level 1 Cost Element Group in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COST_ELEMENT_GROUP_LV PRIMARY KEY (CE_GROUP_LVL3_NR, CHART_OF_ACCOUNTS_CD)
       NOT ENFORCED
)
COMMENT = 'Cost Element Groups - level 3 of the hierarchy';

