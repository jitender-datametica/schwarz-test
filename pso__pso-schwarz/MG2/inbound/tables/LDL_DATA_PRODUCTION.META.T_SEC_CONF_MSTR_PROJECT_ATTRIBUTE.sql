create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_PROJECT_ATTRIBUTE (
	MSTR_ATTR_UNIQUE_NR VARCHAR(512) NOT NULL COMMENT 'The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name',
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_ATTR_NR VARCHAR(32) NOT NULL COMMENT 'The Attribute ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_ATTR_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the attribute in default metadata language of project',
	MSTR_ATTR_FORM_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the attribute form name in default metadata language of project',
	MSTR_ATTR_FORM_NAME_DATATYPE_CD VARCHAR(255) NOT NULL COMMENT 'The Data type of the attribute form like string, number (it is set via list from frontend)',
	CONF_TMSP TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_PROJECT_ATTRIBUTE primary key (MSTR_ATTR_UNIQUE_NR)
)COMMENT='The configuration table which contains the necessary attributes/attribute forms to create security filters'
;