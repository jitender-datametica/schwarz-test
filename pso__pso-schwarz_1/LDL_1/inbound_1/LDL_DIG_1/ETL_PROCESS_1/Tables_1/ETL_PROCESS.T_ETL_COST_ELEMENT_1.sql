/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_ELEMENT_1
   GENERATED FROM POWERDESIGNER ON Montag, 27. Februar 2023 10:05:45
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COST_ELEMENT_1 (
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Cost element Number. Same as the Account_1 Number of the corresponding Profit and Loss Account_1',
   CTRL_AREA_CD                        VARCHAR(5)      COMMENT 'Code of the Controlling Area ',
   CE_VALID_FROM_DT                    DATE            COMMENT 'The start date when this cost element can be used in booking',
   CE_VALID_TO_DT                      DATE            COMMENT 'The end date when this cost element can be used in booking',
   SHORT_NAME_EN                       VARCHAR(100)    COMMENT 'Short description of the Cost Element in English',
   LONG_NAME_EN                        VARCHAR(100)    COMMENT 'Long description of the Cost Element in English',
   SHORT_NAME_DE                       VARCHAR(100)    COMMENT 'Short description of the Cost Element in German',
   LONG_NAME_DE                        VARCHAR(100)    COMMENT 'Long description of the Cost Element in Gernam',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COST_ELEMENT PRIMARY KEY (ACCT_NR) NOT ENFORCED
 )  COMMENT= 'An ETL table that helps populating T_DIM_COST_ELEMENT_1
             The table contains one row per combination of Cost Element and Controlling Area. One cost element is created for every Financial Account_1 of type Profit and Loss Account.
             Cost Element Number is equal to Account_1 Number';
