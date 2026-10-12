create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_CUM_CALENDAR_YEAR_TO_QUARTER (
	CAL_YEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'The calendar year quarter for which the calendar-year-to-quarter interval is defined.',
	INCL_CAL_YEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'The calendar year quarter that needs to be included in the calendar-year-to-quarter interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_CUM_CALENDAR_YEAR_TO_QUARTER primary key (CAL_YEAR_QTR, INCL_CAL_YEAR_QTR)
)COMMENT='This table relates a calendar year quarter to all calendar year quarters that form the calendar-year-to-quarter interval of this quarter. E.g. for Q3/2021 this is Q1/2021, Q2/2021 and Q3/2021.'
;