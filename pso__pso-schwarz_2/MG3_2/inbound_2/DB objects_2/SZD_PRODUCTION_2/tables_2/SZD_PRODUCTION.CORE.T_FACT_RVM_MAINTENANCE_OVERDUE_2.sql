create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_RVM_MAINTENANCE_OVERDUE_2 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	PREV_ACTION_DT DATE NOT NULL COMMENT 'The date when preventive maintenance was carried out on the deposit machine.',
	DUE_DT_FROM DATE NOT NULL COMMENT 'the start of the maintenance due date ',
	DUE_DT_TO DATE NOT NULL COMMENT 'the end of the maintenance due date ',
	OVERDUE_DAY_CNT NUMBER(38,0) NOT NULL COMMENT 'The count of days the maintenance is overdue',
	OVERDUE_CNT NUMBER(38,0) NOT NULL COMMENT 'The count of rvms with maintenance overdue as constant 1',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_RVM_MAINTENANCE_OVERDUE primary key (RVM_SID, CAL_DT)
)COMMENT='Transactional facts capturing the maintenance overdue of RVMs'
;