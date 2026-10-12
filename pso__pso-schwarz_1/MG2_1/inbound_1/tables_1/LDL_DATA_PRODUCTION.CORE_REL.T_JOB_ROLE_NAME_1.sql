create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_JOB_ROLE_NAME_1 (
	JOB_ROLE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the job role.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	JOB_ROLE_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the job role is known, in the language indicated by the language code.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_JOB_ROLE_NAME primary key (JOB_ROLE_SID, LANG_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This table provides translations of the job role name into various languages.'
;