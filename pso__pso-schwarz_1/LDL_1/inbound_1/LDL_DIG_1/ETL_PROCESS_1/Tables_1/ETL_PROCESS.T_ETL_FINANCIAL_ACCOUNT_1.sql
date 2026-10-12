CREATE TABLE ETL_PROCESS.T_ETL_FINANCIAL_ACCOUNT_1 (
	FIN_ACCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the Financial Account_1',
	ACCT_NR VARCHAR(20) COMMENT 'Number of the Account. The there are postings in the GL they are booked to this account_1 number',
	SHORT_NAME_DE VARCHAR(100) COMMENT 'Short description of the Account_1 in German',
	LONG_NAME_DE VARCHAR(100) COMMENT 'Long description of the Account_1 in German',
	INTERNAL_COMPANY_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the company',
	INTERNAL_COMPANY_CD VARCHAR(5) COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
	CHART_OF_ACCOUNTS_CD VARCHAR(5) COMMENT 'Unique Identifier of the Chart of Accounts',
	GROUP_ACCT_NR VARCHAR(20) COMMENT 'For operative accounts ( Chart Of Accounts = ''LDI1'') this is the group account_1 they are asscoiated to. This facilitates reporting at group level',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_ETL_FINANCIAL_ACCOUNT PRIMARY KEY (FIN_ACCT_SID)
)COMMENT='Staging of accounts for core.t_dim_financial_accounts where no source system is available '
;