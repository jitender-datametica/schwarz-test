create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_LOG_TYPE_2 (
	LOG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of the log type like information, debug or error',
	LOG_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The log type descripton',
	constraint PK_T_SEC_CONF_LOG_TYPE primary key (LOG_TYPE_CD)
)COMMENT='The status_2 of sync, if it is sucess or error is'
;