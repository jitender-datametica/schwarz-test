create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_EMPLOYEE_TIME_TRACKING_TYPE_2 (
	EMP_TM_TRACKING_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for employee_2 time tracking events.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	EMP_TM_TRACKING_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for employee_2 time tracking events.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_EMPLOYEE_TIME_TRACKING_TYPE primary key (EMP_TM_TRACKING_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the subtye discriminators for employee_2 time tracking events. It distinguishes between timestamp based and period based time tracking '
;