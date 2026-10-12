/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_PROSHOP_AH_1
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:39:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COST_CENTER_PROSHOP_AH_1 (
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   COST_CENTER_NR                      VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center',
   CC_VALID_FROM_DT                    DATE            NOT NULL COMMENT 'The date from which this Cost Center can be used in bookings',
   CC_VALID_TO_DT                      DATE            COMMENT 'The date till which this Cost Center can be used in bookings',
   CC_GROUP_LVL3_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group  to which the CC Group lvl 4 belongs according to the alternative Hierarchy_1 1',
   CC_GROUP_LVL3_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in English (alternative hierarchy_1 1)',
   CC_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 3 Cost Center Group in German (alternative hierarchy_1 1)',
   CC_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group  to which the CC Group lvl 3 belongs according to the alternative Hierarchy_1 1',
   CC_GROUP_LVL2_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in English (alternative hierarchy_1 1)',
   CC_GROUP_LVL2_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level 2 Cost Center Group in German (alternative hierarchy_1 1)',
   CC_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group  to which the CC Group lvl 2 belongs according to the alternative  Hierarchy_1 1',
   CC_GROUP_LVL1_NAME_EN               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in English (alternative hierarchy_1 1)',
   CC_GROUP_LVL1_NAME_DE               VARCHAR(100)    COMMENT 'Name of the level1 Cost Center Group in German (alternative hierarchy_1 1)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COST_CENTER_PROSHOP_AH PRIMARY KEY (CTRL_AREA_CD, COST_CENTER_NR, CC_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'The table describes alternative hierarchy_1 of Cost Center Groups and their relationship to Cost Centers (top element = ''PSHOP_D888'')';
