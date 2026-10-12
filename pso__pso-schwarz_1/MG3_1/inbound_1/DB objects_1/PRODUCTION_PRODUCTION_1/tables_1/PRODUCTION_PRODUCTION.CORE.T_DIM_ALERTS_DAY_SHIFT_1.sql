create or replace TABLE PRODUCTION_PRODUCTION.CORE.T_DIM_ALERTS_DAY_SHIFT_1 (
	ALERTS_DAY_SHIFT_ID NUMBER(38,0) NOT NULL COMMENT 'Concatenated ID: alerts_day_shift_start_dt + alerts_shift_description_id as integer. Each day has 3 shifts.',
	ALERTS_DAY_SHIFT_END_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	ALERTS_DAY_SHIFT_START_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	ALERTS_SHIFT_DESCRIPTION_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the shift description.',
	ALERTS_DAY_SHIFT_START_TM TIME(9) NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is starting.',
	ALERTS_DAY_SHIFT_END_TM TIME(9) NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is ending.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_T_DIM_ALERTS_DAY_SHIFT primary key (ALERTS_DAY_SHIFT_ID)
)COMMENT='Dimension table with all possible shifts per production day.'
;