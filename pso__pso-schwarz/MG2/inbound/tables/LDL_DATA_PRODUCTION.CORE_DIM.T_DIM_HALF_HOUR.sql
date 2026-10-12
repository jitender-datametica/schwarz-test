create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_HALF_HOUR (
	HALF_HR NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm the minute component. ',
	HALF_HR_BEGIN_TM TIME(9) COMMENT 'The start time (inclusive) of the half-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:29:59.',
	HALF_HR_END_TM TIME(9) COMMENT 'The end time (inclusive) of the half-hour interval. E.g. 00:29:59 for the interval from 00:00:00 to 00:29:59.',
	HR NUMBER(38,0) NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_HALF_HOUR primary key (HALF_HR)
)COMMENT='This minor dimension contains the 48 half-hour intervals of a day.'
;