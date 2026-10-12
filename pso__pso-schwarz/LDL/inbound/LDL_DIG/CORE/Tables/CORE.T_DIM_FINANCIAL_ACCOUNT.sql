/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FINANCIAL_ACCOUNT
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. April 2022 16:59:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_FINANCIAL_ACCOUNT (
   FIN_ACCT_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the Financial Account',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became invalid',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      NOT NULL COMMENT 'Unique Identifier of the Chart of Accounts',
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Number of the Account. The there are postings in the GL they are booked to this account number',
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'In SAP this is the code that identifies a Lidl Company ',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'A flat that shows (if TRUE) that the recotd is currently valid',
   GROUP_ACCT_NR                       VARCHAR(20)     COMMENT 'For operative accounts ( Chart Of Accounts = ''LDI1'') this is the group account they are asscoiated to. This facilitates reporting at group level',
   BALANCE_SHEET_ACCT_FG               BOOLEAN         COMMENT 'A flag that shows (if TRUE) that this is a balance sheet account',
   PL_STATEMENT_ACCT_FG                BOOLEAN         COMMENT 'A flag that shows (if TRUE) that this is a Profit and Loss statements account',
   RECONCILIATION_ACCT_FG              BOOLEAN         COMMENT 'A flag that shows (if TRUE) that this is a Reconciliation Account',
   CASH_ACCT_FG                        BOOLEAN         COMMENT 'A flag that shows (if TRUE) that this is a Cash receipt  / Cash disbursment account',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code according to ISO-4217 identifying the default currency of the account.',
   SHORT_NAME_EN                       VARCHAR(100)    COMMENT 'Short description of the Account in English',
   LONG_NAME_EN                        VARCHAR(100)    COMMENT 'Long description of the Account in English',
   SHORT_NAME_DE                       VARCHAR(100)    COMMENT 'Short description of the Account in German',
   LONG_NAME_DE                        VARCHAR(100)    COMMENT 'Long description of the Account in Gernam',
   SRC_SYS_CREATED_ON                  DATE            COMMENT 'A date when the record was created in the source system',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   CONSTRAINT PK_T_DIM_FINANCIAL_ACCOUNT PRIMARY KEY (FIN_ACCT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The table contains Financial Accounts and their associations with Lidl Companies.
             The granularity is one row per combination of Chart of Accounts, Finnacial Account ( Account Number) and Lidl Company (Comapny Code).';
