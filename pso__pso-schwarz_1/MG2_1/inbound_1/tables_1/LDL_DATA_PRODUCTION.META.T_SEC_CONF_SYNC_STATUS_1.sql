create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_SYNC_STATUS_1 (
	SYNC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_1 of the synchronisation status_1 successful or error',
	SYNC_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of  the synchronisation status_1 ',
	constraint PK_T_SEC_CONF_SYNC_STATUS primary key (SYNC_STATUS_CD)
)COMMENT='The status_1 of sync, if it is sucess or error is'
;