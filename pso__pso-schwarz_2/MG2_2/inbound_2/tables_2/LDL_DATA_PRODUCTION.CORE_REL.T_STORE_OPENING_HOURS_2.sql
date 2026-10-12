create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_STORE_OPENING_HOURS_2 (
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store.',
	DAY_OF_WEEK NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	OPEN_TM TIME(9) NOT NULL COMMENT 'The time (in the local time zone) when the store opens.',
	CLOSE_TM TIME(9) NOT NULL COMMENT 'The time (in the local time zone) when the store closes.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	BREAK_START_TM TIME(9) COMMENT 'in case the store closes over lunch time, this is the start time of the break.',
	BREAK_END_TM TIME(9) COMMENT 'in case the store closes over lunch time, this is the end time of the break.',
	constraint PK_T_STORE_OPENING_HOURS primary key (DAY_OF_WEEK, STORE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the opening times of a store for each weekday.'
;