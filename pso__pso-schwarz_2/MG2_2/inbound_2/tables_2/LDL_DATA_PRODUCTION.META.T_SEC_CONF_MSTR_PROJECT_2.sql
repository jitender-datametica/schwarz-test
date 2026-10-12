create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_PROJECT_2 (
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_PROJ_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the Project default metadata language',
	MSTR_SECURITY_FILTER_FOLDER_NR VARCHAR(32) NOT NULL COMMENT 'The Folder ID where the security filters will be created in (represents the GUID from MicroStrategy-Metadata',
	MSTR_SECURITY_FILTER_PREFIX_TXT VARCHAR(255) NOT NULL COMMENT 'The prefix of security filters, which always be added at beginning during creation',
	MSTR_DATA_USER_GRP_PREFIX_TXT VARCHAR(255) NOT NULL COMMENT 'The prefix of data user group, which always be added at beginning during creation ',
	MSTR_SIAM_USER_GRP_PREFIX_TXT VARCHAR(255) NOT NULL COMMENT 'The prefix of siam user group name, which always be added at beginning during creation',
	MSTR_SIAM_USER_GRP_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The column is currently not in use, it is reserved to know, level of organisation unit_2, where security filters can be necessary',
	CONF_TMSP TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_PROJECT primary key (MSTR_PROJ_NR)
)COMMENT='The configuration table which contains the information about the projects for row level security synch.'
;