create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_TO_PREDICATE (
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_SEC_FILTER_TEMPLATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)',
	MSTR_PREDICATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of predicate (behaves like identifier)',
	CONF_TMSP TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_TO_PREDICATE primary key (MSTR_PROJ_NR, MSTR_SEC_FILTER_TEMPLATE_NAME, MSTR_PREDICATE_NAME)
)COMMENT='The configuration table which contains the relationship which security filter to its predicates'
;