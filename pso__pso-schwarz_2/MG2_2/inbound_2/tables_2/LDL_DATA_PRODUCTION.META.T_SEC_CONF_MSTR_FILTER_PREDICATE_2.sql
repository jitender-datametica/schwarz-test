create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_FILTER_PREDICATE_2 (
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_PREDICATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of predicate (behaves like identifier)',
	PREDICATE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of predicate automic when it is real condition is and complex when it is built on two other predicates',
	MSTR_PREDICATE_LEFT_CHILD_NAME VARCHAR(255) COMMENT 'The name of the predicate on left side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>',
	MSTR_PREDICATE_RIGHT_CHILD_NAME VARCHAR(255) COMMENT 'The name of the predicate on right side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>',
	PREDICATE_FUNCTION_NR VARCHAR(255) COMMENT 'The function for the automic predicates like Equals, Greater, In ... ',
	MSTR_ATTR_UNIQUE_NR VARCHAR(512) COMMENT 'The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name',
	MSTR_ATTR_NR VARCHAR(32) COMMENT 'The Attribute ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_ATTR_NAME VARCHAR(255) COMMENT 'The Name of the attribute in default metadata language of project',
	MSTR_ATTR_FORM_NAME VARCHAR(255) COMMENT 'The Name of the attribute form name in default metadata language of project',
	MSTR_ATTR_FORM_NAME_DATATYPE_CD VARCHAR(255) COMMENT 'The Data type of the attribute form like string, number (it is set via list from frontend)',
	PREDICATE_PARAM_NAME VARCHAR(255) COMMENT 'The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country_2 of a predicate as in Land_2@ISO= DE ',
	CONF_TMSP TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_FILTER_PREDICATE primary key (MSTR_PROJ_NR, MSTR_PREDICATE_NAME)
)COMMENT='The configuration table which contains the information about a predicate of security filter, how a filter condition will be created'
;