create or replace TABLE LDL_DATA_PRODUCTION.META.T_USER_1 (
	USER_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the user is identified on the system.',
	EMP_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the employee_1 who owns this user.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	SYS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the IT system.',
	constraint PK_T_USER primary key (SYS_NAME, USER_NAME)
)COMMENT='A user is an account_1 on the data warehouse that allows to use the system. (Not every user is assigned to a single physical person.)'
;