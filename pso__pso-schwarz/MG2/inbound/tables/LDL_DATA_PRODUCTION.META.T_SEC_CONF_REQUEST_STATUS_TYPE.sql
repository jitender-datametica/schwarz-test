create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_REQUEST_STATUS_TYPE (
	REQUEST_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status of a grant status if it is approved, requested or denied.',
	REQUEST_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of request status',
	constraint PK_T_SEC_CONF_REQUEST_STATUS_TYPE primary key (REQUEST_STATUS_CD)
)COMMENT='The entity definies the lifecycle of the granting an object to an user group.'
;