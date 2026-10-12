create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_BUSINESS_USER_GROUP_1 (
	MSTR_BUS_USER_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment',
	MSTR_BUS_USER_GRP_NR VARCHAR(32) COMMENT 'The User Group ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_BUS_USER_GRP_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the MicroStrategy User Group default metadata language',
	MSTR_BUS_USER_GRP_SIAM_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the MicroStrategy User Group in SIAM default metadata language',
	USER_GRP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The Type of the Business User Group, if it is Ressort or Functional Group.',
	CONF_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_BUSINESS_USER_GROUP primary key (MSTR_BUS_USER_GRP_SID)
)COMMENT='The configuration table which contains the information about business user groups for object security'
;