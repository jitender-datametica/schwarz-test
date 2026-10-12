create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_QUARTER_HOUR_1 (
	QTR_HR NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_1 the minute component. ',
	QTR_HR_BEGIN_TM TIME(9) COMMENT 'The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.',
	QTR_HR_END_TM TIME(9) COMMENT 'The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.',
	HR NUMBER(38,0) NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	HALF_HR NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_QUARTER_HOUR primary key (QTR_HR)
)COMMENT='This minor dimension contains the 96 quarter-hour intervals of a day.'
;