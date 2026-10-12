create or replace TABLE LDL_DATA_PRODUCTION.POLICIES.T_SEC_RAP_CORE_SALES_COMPANY_NR (
	ROLE_NAME VARCHAR(100),
	SALES_COMPANY_NR VARCHAR(50)
)COMMENT='Table which contains roles which are allowed to see certain companies (company level)'
;