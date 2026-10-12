create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_USER_GROUP_TO_OBJECT (
	MSTR_BUS_USER_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment',
	MSTR_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups',
	CONF_ACTIVE_FROM_DT DATE NOT NULL COMMENT 'The point in time when this record became valid.',
	CONF_ACTIVE_TO_DT DATE NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	CONF_ACTIVE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between conf_valid_from and conf_valid_to.',
	REQUEST_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status of a grant status if it is approved, requested or denied.',
	GRANTED_FG BOOLEAN NOT NULL COMMENT 'The value of granted flag, if a user group has an access or not',
	REQUESTOR_USER_NAME VARCHAR(100) NOT NULL COMMENT 'The MSTR-User who enters the value to the system',
	REQUEST_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point of the time, when the entry is done.',
	APPROVER_USER_NAME VARCHAR(100) COMMENT 'The MSTR-User who approves the value entered to the system',
	APPROVED_TMSP TIMESTAMP_TZ(9) COMMENT 'The point of the time when the entry is approved.',
	constraint PK_T_SEC_CONF_MSTR_USER_GROUP_TO_OBJECT primary key (MSTR_BUS_USER_GRP_SID, MSTR_OBJ_SID, CONF_ACTIVE_FROM_DT)
)COMMENT='The relationship table which contains the information which user is allowed to access which object ( Report,Dossier, Metric ACL)'
;