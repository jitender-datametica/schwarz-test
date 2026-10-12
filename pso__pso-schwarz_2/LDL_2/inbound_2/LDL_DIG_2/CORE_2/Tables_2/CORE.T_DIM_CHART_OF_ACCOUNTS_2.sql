/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_CHART_OF_ACCOUNTS_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 3. Februar 2022 15:41:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHART_OF_ACCOUNTS_2 (
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      NOT NULL COMMENT 'Unique Identifier of the Chart of Accounts',
   CHART_OF_ACCT_NAME_EN               VARCHAR(100)    COMMENT 'Name of the ledger in English',
   CHART_OF_ACCT_NAME_DE               VARCHAR(100)    COMMENT 'Name of the ledger in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CHART_OF_ACCOUNTS PRIMARY KEY (CHART_OF_ACCOUNTS_CD)
       NOT ENFORCED
)COMMENT = 'A minor dimensiont that contains all Chart of Accounts used by Lidl Companies';