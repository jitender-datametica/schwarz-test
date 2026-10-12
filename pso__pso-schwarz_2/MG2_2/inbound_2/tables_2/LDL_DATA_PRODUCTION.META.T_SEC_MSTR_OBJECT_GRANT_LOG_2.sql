create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_MSTR_OBJECT_GRANT_LOG_2 (
	MSTR_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups',
	MSTR_BUS_USER_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment',
	MSTR_ENV_NAME VARCHAR(255) NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already',
	LOG_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table',
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	SYNC_TYPE_CD VARCHAR(20) COMMENT 'The type of the synchronisation as revode or grant',
	SYNC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_2 (OK/ERR) if the synchoronization is successful or not',
	SYNC_ERROR_MSG_TXT VARCHAR(1000) COMMENT 'The Error Message if the synchoronization is unsuccessful',
	LOG_VALID_FG BOOLEAN NOT NULL COMMENT 'The current valid entry to identify current status_2 of synchoronization for a snowflake group/user project',
	constraint PK_T_SEC_MSTR_OBJECT_GRANT_LOG primary key (MSTR_OBJ_SID, MSTR_BUS_USER_GRP_SID, MSTR_ENV_NAME, LOG_TMSP)
)COMMENT='Log table which contains the information, when the grants on objects are synchoronized from snowflake to mstr project'
;