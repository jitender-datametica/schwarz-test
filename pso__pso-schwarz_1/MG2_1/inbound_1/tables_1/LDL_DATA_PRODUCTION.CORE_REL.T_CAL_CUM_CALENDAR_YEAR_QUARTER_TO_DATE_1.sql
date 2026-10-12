create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_DATE_1 (
	CAL_DT DATE NOT NULL COMMENT 'The date for which the calendar_1-year-quarter-to-date interval is defined.',
	INCL_CAL_DT DATE NOT NULL COMMENT 'The date that needs to be included in the calendar_1-year-quarter-to-date interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_DATE primary key (CAL_DT, INCL_CAL_DT)
)COMMENT='This table relates a calendar_1 date to all dates that form the calendar_1-year-quarter-to-date interval for this date. E.g. for August 15th 2021 this is all dates from July 1st 2021 to August 15th, inclusively.'
;