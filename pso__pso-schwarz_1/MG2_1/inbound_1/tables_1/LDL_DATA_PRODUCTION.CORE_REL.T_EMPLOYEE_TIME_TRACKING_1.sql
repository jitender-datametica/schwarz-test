create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_EMPLOYEE_TIME_TRACKING_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the time booking is accrued.',
	EMP_HASH VARCHAR(32) NOT NULL COMMENT 'The encrypted employee_1 number.',
	BUS_DT DATE NOT NULL COMMENT 'The business date to which the time record relates.',
	EMP_TM_TRACKING_NR NUMBER(38,0) NOT NULL COMMENT 'A number identifying the time booking record in the operational system.',
	EMP_TM_TRACKING_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for administrative events.',
	EMP_TM_TRACKING_METHOD_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how employees track their time. Time records can be recorded by a terminal or can be entered manually.',
	EMP_TM_TRACKING_STATUS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_1 for employee_1 time tracking records. A record may be active or cancelled.',
	EMP_TM_EVENT_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the kind time recording event which is booked for an employee. This includes start of work, end of work, start of break and end of break.',
	TM_TRACKING_TMSP TIMESTAMP_TZ(9) COMMENT 'The point in time when the time tracking record was created.',
	EMP_TM_PERIOD_TYPE_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc.',
	PERIOD_START_TMSP TIMESTAMP_TZ(9) COMMENT 'The start timestamp of the time period which is tracked.',
	PERIOD_END_TMSP TIMESTAMP_TZ(9) COMMENT 'The end timestamp of the time period which is tracked.',
	HR_CNT NUMBER(38,2) COMMENT 'The number of hours which are booked. This time does not include breaks',
	BREAK_MIN_CNT NUMBER(38,0) COMMENT 'Break time in minutes.',
	BOOKING_DT DATE COMMENT 'The date when the time booking was recorded in the operational system.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_EMPLOYEE_TIME_TRACKING primary key (INT_ORG_SID, EMP_HASH, BUS_DT, EMP_TM_TRACKING_NR)
)COMMENT='Employees track their work times, as well as their absences and other activities, such as training.'
;