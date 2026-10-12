create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_SYNC_TYPE_2 (
	SYNC_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of the synchronisation as revode or grant',
	SYNC_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of  the synchronisation type ',
	constraint PK_T_SEC_CONF_SYNC_TYPE primary key (SYNC_TYPE_CD)
)COMMENT='The type of sync, if it is a grant or revoke is'
;