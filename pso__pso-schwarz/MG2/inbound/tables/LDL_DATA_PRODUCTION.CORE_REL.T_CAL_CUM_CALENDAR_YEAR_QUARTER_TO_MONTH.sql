create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_MONTH (
	CAL_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar month for which the calendar-year-quarter-to-month interval is defined.',
	INCL_CAL_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar month that needs to be included in the calendar-year-quarter-to-month interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_MONTH primary key (CAL_MONTH, INCL_CAL_MONTH)
)COMMENT='This table relates a month to all months that form the calendar-year-quarter-to-month interval of this month. E.g. for May 2019 this is April and May 2019.'
;