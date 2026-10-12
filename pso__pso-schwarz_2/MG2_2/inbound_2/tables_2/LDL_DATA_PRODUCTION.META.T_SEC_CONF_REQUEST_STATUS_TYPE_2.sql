create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_REQUEST_STATUS_TYPE_2 (
	REQUEST_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_2 of a grant status_2 if it is approved, requested or denied.',
	REQUEST_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of request status_2',
	constraint PK_T_SEC_CONF_REQUEST_STATUS_TYPE primary key (REQUEST_STATUS_CD)
)COMMENT='The entity definies the lifecycle of the granting an object to an user group.'
;