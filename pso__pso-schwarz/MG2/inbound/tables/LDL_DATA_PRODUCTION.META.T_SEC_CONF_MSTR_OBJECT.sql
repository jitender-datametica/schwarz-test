create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_MSTR_OBJECT (
	MSTR_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups',
	MSTR_PROJ_NR VARCHAR(32) COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_OBJ_NR VARCHAR(32) COMMENT 'The Object ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_OBJ_NAME VARCHAR(255) NOT NULL COMMENT 'The Name of the MicroStrategy Object default metadata language',
	OBJ_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The Type of the MicroStrategy Apllication, if it is Report, Metric, Dossier ....',
	CONF_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_MSTR_OBJECT primary key (MSTR_OBJ_SID)
)COMMENT='The configuration table which contains the information about the objects like reports,dossiers but also ressort user groups of metrics for object security but'
;