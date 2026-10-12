create or replace TABLE LDL_DATA_PRODUCTION.POLICIES.T_SEC_MP_STAGING_CORE_LOADER_ROLE_NAME_WHITELIST (
	TYPE VARCHAR(50) NOT NULL COMMENT 'Type of object which is allowed to view securable data e.g. ROLE or USER',
	NAME VARCHAR(100) NOT NULL COMMENT 'Name of role/user'
)COMMENT='Table which contains dedicated Core-Loader roles which are allowed to de-mask to load data into intermediate staging tables'
;