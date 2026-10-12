create or replace TABLE LDL_DATA_PRODUCTION.POLICIES.T_SEC_RAP_CORE_USER_NAME_ROLE_NAME_WHITELIST (
	TYPE VARCHAR(50),
	NAME VARCHAR(100)
)COMMENT='Table which contains roles or users which are allowed to see everything (ETL Jobs, Developers, etc.)'
;