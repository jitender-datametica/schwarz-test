create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_MSTR_GRANT_RUN_LOG_STEPS_1 (
	MSTR_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups',
	MSTR_BUS_USER_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment',
	MSTR_ENV_NAME VARCHAR(255) NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already',
	LOG_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table',
	PYTHON_PROC_NAME VARCHAR(255) NOT NULL COMMENT 'The name of the python procedure where the log entiries are coming',
	PYTHON_PROC_STEP_NAME VARCHAR(255) NOT NULL COMMENT 'The current step in the python procedure where the log entiries are coming',
	PYTHON_PROC_PARAM_TXT VARCHAR(2048) NOT NULL COMMENT 'The parameters provided to python procedure as json format',
	MSTR_PROJ_NR VARCHAR(32) NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata',
	LOG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The level of logging I -> Information E-> Error ...',
	PYTHON_PROC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_1 of python procedure if run is successful or not',
	constraint PK_T_SEC_MSTR_GRANT_RUN_LOG_STEPS primary key (MSTR_OBJ_SID, MSTR_BUS_USER_GRP_SID, MSTR_ENV_NAME, PYTHON_PROC_NAME, PYTHON_PROC_STEP_NAME, LOG_TMSP)
)COMMENT='Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error'
;