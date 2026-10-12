/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_USER_COST_CENTER_RELATION_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 11:29:43
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_USER_COST_CENTER_RELATION_1 (
   USERNAME                            VARCHAR(50)     COMMENT 'Username of the user (Lidl Digital employee_1)
            Username of the user (Lidl Digital employee_1)',
   FULL_MSTR_LOGIN_NAME                VARCHAR(100)    NOT NULL COMMENT 'Microstrategy login of the user (Lidl Digital employee_1)',
   FISCAL_YEAR                         NUMBER(38,0)    NOT NULL COMMENT 'A number that represents the fiscal year of the hierarchy_1',
   CC_GROUP_SECURITY_LVL               VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center Group to which the user has access to',
   CC_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 1 to which this Cost Center belongs in the selected business year hierarchy_1',
   CC_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 2 to which this Cost Center belongs in the selected business year hierarchy_1',
   CC_GROUP_LVL3_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 3 to which this Cost Center belongs in the selected business year hierarchy_1',
   CC_GROUP_LVL4_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 4 to which this Cost Center belongs in the selected business year hierarchy_1',
   CC_GROUP_LVL5_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 5 to which this Cost Center belongs in the selected business year hierarchy_1',
   CC_GROUP_LVL6_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Center Group Lvl 6 to which this Cost Center belongs in the selected business year hierarchy_1',
   COST_CENTER_NR                      VARCHAR(20)     COMMENT 'Identifier of the Cost Center',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_USER_COST_CENTER_RELATION PRIMARY KEY (FULL_MSTR_LOGIN_NAME, FISCAL_YEAR, CC_GROUP_SECURITY_LVL) NOT ENFORCED
 )  COMMENT= 'This table contains users information and the highest level cost_center_group to which they have access to.';
