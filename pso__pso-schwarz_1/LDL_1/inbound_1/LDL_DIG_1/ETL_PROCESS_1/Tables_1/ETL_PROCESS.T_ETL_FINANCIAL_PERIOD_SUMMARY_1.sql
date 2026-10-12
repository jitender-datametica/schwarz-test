/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_FINANCIAL_PERIOD_SUMMARY_1
   GENERATED FROM POWERDESIGNER ON Freitag, 20. Mai 2022 07:22:10
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_FINANCIAL_PERIOD_SUMMARY_1 (
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the accounting document is posted',
   FISCAL_PERIOD                       NUMBER          NOT NULL COMMENT 'Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods',
   COST_CENTER_NR                      VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center',
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Number of the Account. The there are postings in the GL they are booked to this account_1 number',
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company',
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   ACCT_DATA_SRC_NAME                  VARCHAR(20)     NOT NULL COMMENT 'Name  of the source of the aggregated data',
   POSTING_DT                          DATE            COMMENT 'The date when the posting was made',
   TOTAL_AMOUNT_NET_EUR_VAL            NUMBER(38, 5)   COMMENT 'The aggregated amount of all transactions for the fiscal period booked to the given cost center, company and account_1 number',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_FINANCIAL_PERIOD_SUMMARY PRIMARY KEY (FISCAL_YEAR, FISCAL_PERIOD, COST_CENTER_NR, ACCT_NR, INTERNAL_COMPANY_SID, CTRL_AREA_CD, ACCT_DATA_SRC_NAME) NOT ENFORCED
 )  COMMENT= 'A table that helps the ETL process of populating T_AGG_FINANCIAL_PERIOD_SUMMARY. Contains aggregated data for a fiscal period for achieved results at company, cost_center and account_1 (cost element) level';
