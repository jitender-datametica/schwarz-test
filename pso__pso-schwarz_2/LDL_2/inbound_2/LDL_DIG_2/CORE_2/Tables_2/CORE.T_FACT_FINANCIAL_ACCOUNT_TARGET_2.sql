/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_FINANCIAL_ACCOUNT_TARGET_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 18. Mai 2022 08:11:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_FINANCIAL_ACCOUNT_TARGET_2 (
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the accounting document is posted',
   FISCAL_PERIOD                       NUMBER          NOT NULL COMMENT 'Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods',
   COST_CENTER_NR                      VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center',
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Number of the Account. The there are postings in the GL they are booked to this account_2 number',
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company',
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'Code of the Controlling Area',
   POSTING_DT                          DATE            COMMENT 'The date when the posting was made',
   POSTING_GROUP_TGT_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'The planned value of the posting group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   CONSTRAINT PK_T_FACT_FINANCIAL_ACCOUNT_TARGET PRIMARY KEY (FISCAL_YEAR, FISCAL_PERIOD, COST_CENTER_NR, ACCT_NR, INTERNAL_COMPANY_SID, CTRL_AREA_CD) NOT ENFORCED
 )  COMMENT= 'The snapshot_2 fact holds the KER account_2 target plan values at the fiscal year and period level';
