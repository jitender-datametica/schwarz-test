/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_ELEMENT
   GENERATED FROM POWERDESIGNER ON  2022-04-11 12:53:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COST_ELEMENT (
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Cost element Number. Same as the Account Number of the corresponding Profit and Loss Account',
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area ',
   CE_VALID_FROM_DT                    DATE            NOT NULL COMMENT 'The start date when this cost element can be used in booking',
   CE_VALID_TO_DT                      DATE            NOT NULL COMMENT 'The end date when this cost element can be used in booking',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      COMMENT 'Unique Identifier of the Chart of Accounts',
   SHORT_NAME_EN                       VARCHAR(100)    COMMENT 'Short description of the Cost Element in English',
   LONG_NAME_EN                        VARCHAR(100)    COMMENT 'Long description of the Cost Element in English',
   SHORT_NAME_DE                       VARCHAR(100)    COMMENT 'Short description of the Cost Element in German',
   LONG_NAME_DE                        VARCHAR(100)    COMMENT 'Long description of the Cost Element in Gernam',
   CE_GROUP_LVL3_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Element Group (a.k.a. KER Position) to which this Cost Element belongs according to the Standard  Hierarchy',
   CE_GROUP_LVL3_NAME_EN               VARCHAR(100)    COMMENT 'Long description of the level 3 Cost Element Group in English',
   CE_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Short description of the  level 3 Cost Element Group in German',
   CE_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl3 belongs according to the Standard  Hierarchy',
   CE_GROUP_LVL2_NAME_EN               VARCHAR(100)    COMMENT 'Long description of the level 2 Cost Element Group in English',
   CE_GROUP_LVL2_NAME_DE               VARCHAR(100)    COMMENT 'Short description of the  level 2 Cost Element Group in German',
   CE_GROUP_LVL1_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl2 belongs according to the Standard  Hierarchy',
   CE_GROUP_LVL1_NAME_EN               VARCHAR(100)    COMMENT 'Long description of the  level 1 Cost Element Group in English',
   CE_GROUP_LVL1_NAME_DE               VARCHAR(100)    COMMENT 'Short description of the  level 1 Cost Element Group in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COST_ELEMENT PRIMARY KEY (CTRL_AREA_CD, ACCT_NR, CE_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'The table contains one row per combination of Cost Element and Controlling Area. One cost element is created for every Financial Account of type Profit and Loss Account.
             Cost Element Number is equal to Account Number';
