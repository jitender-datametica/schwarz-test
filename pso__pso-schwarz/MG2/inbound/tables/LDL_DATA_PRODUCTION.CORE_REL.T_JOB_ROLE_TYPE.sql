create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_JOB_ROLE_TYPE (
	JOB_ROLE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of job role.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	JOB_ROLE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of job role.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_JOB_ROLE_TYPE primary key (JOB_ROLE_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the types of job roles. E.g. store manager, sales manager, account manager, etc.'
;