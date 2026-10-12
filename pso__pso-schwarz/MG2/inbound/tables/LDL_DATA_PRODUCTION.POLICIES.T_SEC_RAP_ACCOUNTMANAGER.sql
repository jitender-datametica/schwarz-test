create or replace TABLE LDL_DATA_PRODUCTION.POLICIES.T_SEC_RAP_ACCOUNTMANAGER (
	ACCT_MGR_DISTRICT_SID NUMBER(38,0) NOT NULL,
	ACCT_MGR_DISTRICT_NR VARCHAR(20),
	ACCT_MGR_DISTRICT_NAME VARCHAR(100),
	SALES_COMPANY_NR VARCHAR(20),
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL,
	BENCHMARK_TYPE_ID NUMBER(1,0) NOT NULL,
	LOGIN_NAME_EMAIL VARCHAR(250)
)COMMENT='Table which contains information about the accountmanagers & their login-name for user recognition in session. Table has a denomalized structure optimized for policy use & its perfomance. Original data source - internal organization entity & login-name from OSO data source'
;