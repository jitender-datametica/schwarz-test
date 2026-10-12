create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_1 (
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_SEC_FILTER_TEMPLATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)',
	MSTR_SEC_FILTER_EXTENSION_TXT VARCHAR(255) NOT NULL COMMENT 'The name extension of security filter, which will be append to prefix defined at project level',
	SF_ROLE_USER_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The level of the organisation unit_1 COUNTRY_1/SALES_1 COMPANY/SALES_1 MANAGER... that the security filter is used',
	CONF_TMSP TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE primary key (MSTR_PROJ_NR, MSTR_SEC_FILTER_TEMPLATE_NAME)
)COMMENT='The configuration table which contains the relationship which security filter is set to which organisation unit_1'
;