create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_EMPLOYEE_TIME_PERIOD_TYPE_2 (
	EMP_TM_PERIOD_TYPE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2 organization which uses this time period type.',
	EMP_TM_PERIOD_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The numeric identifier of the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc. The identifier is specific to the country_2 organization.',
	EMP_TM_PERIOD_TYPE_CD VARCHAR(20) COMMENT 'The code which identifies the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc. The code is specific to the country_2 organization.',
	EMP_TM_PERIOD_TYPE_SHORT_DESCR VARCHAR(250) COMMENT 'A short textual description / abbreviation for the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc.',
	EMP_TM_PERIOD_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc.',
	PERF_RELEVANT_FG BOOLEAN COMMENT 'An indicator showing, if the time period type is to be considered for calculating the net hours KPI.',
	ON_SITE_FG BOOLEAN COMMENT 'An indicator showing, if work was performed on-site.',
	ACTIVE_FROM_DT DATE NOT NULL COMMENT 'The date when this record becomes valid from a business perspective.',
	ACTIVE_TO_DT DATE NOT NULL COMMENT 'The date when this record is no longer valid from a business perspective.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_EMPLOYEE_TIME_PERIOD_TYPE primary key (EMP_TM_PERIOD_TYPE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This minor entity defines the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc.'
;