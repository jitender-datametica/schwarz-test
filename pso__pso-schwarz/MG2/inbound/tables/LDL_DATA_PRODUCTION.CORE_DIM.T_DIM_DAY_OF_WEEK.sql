create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_DAY_OF_WEEK (
	DAY_OF_WEEK NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	DAY_OF_WEEK_SHORT_NAME VARCHAR(100) NOT NULL COMMENT 'The abbreviation for the weekday in group language, i.e. in German, ',
	DAY_OF_WEEK_SHORT_NAME_DE VARCHAR(100) COMMENT 'The abbreviation for the weekday in German, ',
	DAY_OF_WEEK_SHORT_NAME_EN VARCHAR(100) COMMENT 'The abbreviation for the weekday in English',
	DAY_OF_WEEK_NAME VARCHAR(100) NOT NULL COMMENT 'The full name for day of the week in group language, i.e. in German.',
	DAY_OF_WEEK_NAME_DE VARCHAR(100) COMMENT 'The full name for day of the week in German.',
	DAY_OF_WEEK_NAME_EN VARCHAR(100) COMMENT 'The full name for day of the week in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_DAY_OF_WEEK primary key (DAY_OF_WEEK)
)COMMENT='This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...'
;