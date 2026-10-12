create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_USER_GROUP_TYPE_1 (
	USER_GRP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of the user group technical or business is',
	USER_GRP_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of  user group type',
	constraint PK_T_SEC_CONF_MSTR_USER_GROUP_TYPE primary key (USER_GRP_TYPE_CD)
)COMMENT='The user group type, if the user group is business or techical relevant'
;