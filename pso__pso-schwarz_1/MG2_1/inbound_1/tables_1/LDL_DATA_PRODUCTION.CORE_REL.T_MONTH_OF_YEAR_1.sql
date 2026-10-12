create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_MONTH_OF_YEAR_1 (
	MONTH_OF_YEAR NUMBER(38,0) NOT NULL COMMENT 'The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	MONTH_OF_BUS_YEAR NUMBER(38,0) NOT NULL COMMENT 'The month of the business year (starting in March for Lidl) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	MONTH_OF_YEAR_NAME VARCHAR(100) NOT NULL COMMENT 'The full name for the month of the year. E.g. \""January\""',
	MONTH_OF_SHORT_NAME VARCHAR(100) NOT NULL COMMENT 'The short name / abbreviation for month of the year. E.g. \""Jan\""',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_MONTH_OF_YEAR primary key (MONTH_OF_YEAR, LANG_CD)
)COMMENT='This minor entity contains the names of the twelve months of the year. (January, February, ..., December)'
;