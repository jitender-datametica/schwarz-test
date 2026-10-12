create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_SYNC_STATUS (
	SYNC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status of the synchronisation status successful or error',
	SYNC_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of  the synchronisation status ',
	constraint PK_T_SEC_CONF_SYNC_STATUS primary key (SYNC_STATUS_CD)
)COMMENT='The status of sync, if it is sucess or error is'
;