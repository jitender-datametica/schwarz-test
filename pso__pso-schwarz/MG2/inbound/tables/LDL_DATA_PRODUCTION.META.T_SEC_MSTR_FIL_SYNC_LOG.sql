create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_MSTR_FIL_SYNC_LOG (
	SF_ROLE_USER_NAME VARCHAR(255) NOT NULL COMMENT 'The Snowflake Role or User name which is synchoronized to MicroStrategy Project',
	MSTR_ENV_NAME VARCHAR(255) NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already',
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_SEC_FILTER_TEMPLATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)',
	MSTR_SECURITY_FILTER_NAME VARCHAR(255) NOT NULL COMMENT 'The complete name of the security filter that is created on MicroStrategy Project',
	MSTR_SECURITY_FILTER_NR VARCHAR(32) NOT NULL COMMENT 'The Security Filter ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_DATA_USER_GRP_NAME VARCHAR(255) NOT NULL COMMENT 'The complete data user group name that is created for MicroStrategy Project',
	MSTR_DATA_USER_GRP_NR VARCHAR(32) NOT NULL COMMENT 'The data user group ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_SIAM_USER_GRP_NAME VARCHAR(255) NOT NULL COMMENT 'The complete siam user group name that is created for MicroStrategy Project',
	MSTR_SIAM_USER_GRP_NR VARCHAR(32) NOT NULL COMMENT 'The siam user group ID, which represents the GUID from MicroStrategy-Metadata',
	LOG_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table',
	SYNC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status (OK/ERR) if the synchoronization is successful or not',
	SYNC_ERROR_MSG_TXT VARCHAR(1000) COMMENT 'The Error Message if the synchoronization is unsuccessful',
	LOG_VALID_FG BOOLEAN NOT NULL COMMENT 'The current valid entry to identify current status of synchoronization for a snowflake group/user project',
	constraint PK_T_SEC_MSTR_FIL_SYNC_LOG primary key (SF_ROLE_USER_NAME, MSTR_ENV_NAME, MSTR_PROJ_NR, MSTR_SEC_FILTER_TEMPLATE_NAME, LOG_TMSP, LOG_VALID_FG)
)COMMENT='Log table which contains the information, when the security filters are synchoronized from snowflake to mstr project'
;