create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_MSTR_RUN_LOG_STEPS_1 (
	SF_ROLE_USER_NAME VARCHAR(255) NOT NULL COMMENT 'The Snowflake Role or User name which is synchoronized to MicroStrategy Project',
	MSTR_ENV_NAME VARCHAR(255) NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already',
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	MSTR_SEC_FILTER_TEMPLATE_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)',
	PYTHON_PROC_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the python procedure where the log entiries are coming',
	PYTHON_PROC_STEP_NAME VARCHAR(255) NOT NULL COMMENT 'The current step in the python procedure where the log entiries are coming',
	PYTHON_PROC_PARAM_TXT VARCHAR(2048) NOT NULL COMMENT 'The parameters provided to python procedure as json format',
	LOG_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The level of logging I -> Information E-> Error ...',
	PYTHON_PROC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_1 of python procedure if run is successful or not',
	LOG_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table',
	constraint PK_T_SEC_MSTR_RUN_LOG_STEPS primary key (SF_ROLE_USER_NAME, MSTR_ENV_NAME, MSTR_PROJ_NR, MSTR_SEC_FILTER_TEMPLATE_NAME, PYTHON_PROC_NAME, PYTHON_PROC_STEP_NAME, LOG_TMSP)
)COMMENT='Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error'
;