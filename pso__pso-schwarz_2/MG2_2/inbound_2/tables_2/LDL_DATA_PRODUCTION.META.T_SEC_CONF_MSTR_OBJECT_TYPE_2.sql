create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_OBJECT_TYPE_2 (
	OBJ_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of the object report or metric user group',
	OBJ_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of  microstrategy object type',
	constraint PK_T_SEC_CONF_MSTR_OBJECT_TYPE primary key (OBJ_TYPE_CD)
)COMMENT='The user group type, if the user group is business or techical relevant'
;